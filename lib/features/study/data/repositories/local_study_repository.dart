// lib/features/study/data/repositories/local_study_repository.dart
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studymate_ai_app/app/core/di/prefs.dart';
import 'package:studymate_ai_app/features/study/domain/entities/study_item.dart';
import 'package:studymate_ai_app/features/study/domain/repositories/study_repository.dart';

/// DI: SharedPreferences 기반 로컬 구현
final localStudyRepositoryProvider = Provider<StudyRepository>((ref) {
  final prefs = ref.watch(sharedPrefsProvider);
  return LocalStudyRepository(prefs);
});

class LocalStudyRepository implements StudyRepository {
  LocalStudyRepository(this._prefs);
  final SharedPreferences _prefs;

  static const _kKey = 'study_items_v1';

  // ---------------------------
  // 내부 유틸
  // ---------------------------
  Future<List<StudyItem>> _readAll() async {
    final raw = _prefs.getString(_kKey);
    if (raw == null || raw.isEmpty) return const <StudyItem>[];
    final decoded = jsonDecode(raw);
    final list = (decoded is List)
        ? decoded.cast<Map<String, dynamic>>()
        : <Map<String, dynamic>>[];
    return list.map(_fromMap).toList(growable: false);
  }

  Future<void> _saveAll(List<StudyItem> items) async {
    final enc = jsonEncode(items.map(_toMap).toList(growable: false));
    await _prefs.setString(_kKey, enc);
  }

  String _newId() => DateTime.now().microsecondsSinceEpoch.toString();

  Map<String, dynamic> _toMap(StudyItem e) => e.toJson();

  StudyItem _fromMap(Map<String, dynamic> m) => StudyItem.fromJson(m);

  // ---------------------------
  // 인터페이스 구현
  // ---------------------------
  @override
  Future<List<StudyItem>> fetchAll() => _readAll();

  @override
  Future<StudyItem> create({
    required String title,
    double progress = 0.0,
    List<String> tags = const <String>[],
  }) async {
    final all = await _readAll();
    final item = StudyItem(
      id: _newId(),
      title: title,
      progress: progress,
      tags: tags,
      lastActivity: DateTime.now(),
    );
    await _saveAll([...all, item]);
    return item;
  }

  @override
  Future<StudyItem> update({
    required String id,
    double? progress,
    List<String>? tags,
    String? title,
  }) async {
    final all = await _readAll();
    StudyItem? updated;

    final next = all
        .map((e) {
          if (e.id != id) return e;
          updated = StudyItem(
            id: e.id,
            title: title ?? e.title,
            progress: progress ?? e.progress,
            tags: tags ?? e.tags,
            lastActivity: DateTime.now(),
          );
          return updated!;
        })
        .toList(growable: false);

    if (updated == null) {
      throw StateError('StudyItem not found for id=$id');
    }
    await _saveAll(next);
    return updated!;
  }

  @override
  Future<void> delete(String id) async {
    final all = await _readAll();
    final next = all.where((e) => e.id != id).toList(growable: false);
    await _saveAll(next);
  }
}
