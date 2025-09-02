import 'dart:convert';
import 'package:drift/drift.dart' as d;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studymate_ai_app/local/db/app_database.dart';
import 'package:studymate_ai_app/features/study/domain/entities/study_item.dart';
import 'package:studymate_ai_app/features/study/domain/repositories/study_repository.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) => AppDatabase());

class DriftStudyRepository implements StudyRepository {
  DriftStudyRepository(this._db);
  final AppDatabase _db;

  @override
  Future<List<StudyItem>> fetchAll() async {
    final rows = await _db.getAllStudies();
    return rows.map((r) {
      final tags = (jsonDecode(r.tagsJson) as List<dynamic>).map((e) => e.toString()).toList(growable: false);
      return StudyItem(
        id: r.id,
        title: r.title,
        progress: r.progress,
        lastActivity: DateTime.fromMillisecondsSinceEpoch(r.lastActivityMillis),
        tags: tags,
      );
    }).toList(growable: false);
  }

  @override
  Future<StudyItem> create({required String title, double progress = 0.0, List<String> tags = const []}) async {
    final now = DateTime.now();
    final id = now.microsecondsSinceEpoch.toString();
    final data = StudiesCompanion(
      id: d.Value(id),
      title: d.Value(title),
      progress: d.Value(progress.clamp(0.0, 1.0).toDouble()),
      lastActivityMillis: d.Value(now.millisecondsSinceEpoch),
      tagsJson: d.Value(jsonEncode(tags)),
    );
    await _db.insertStudy(data);
    return StudyItem(id: id, title: title, progress: progress, lastActivity: now, tags: tags);
  }

  @override
  Future<StudyItem> update({required String id, String? title, double? progress, List<String>? tags}) async {
    final now = DateTime.now();
    final existing = (await _db.getAllStudies()).where((e) => e.id == id).toList();
    if (existing.isEmpty) throw StateError('Study not found');
    final cur = existing.first;
    final data = StudiesCompanion(
      id: d.Value(id),
      title: d.Value(title ?? cur.title),
      progress: d.Value((progress ?? cur.progress).clamp(0.0, 1.0).toDouble()),
      lastActivityMillis: d.Value(now.millisecondsSinceEpoch),
      tagsJson: d.Value(jsonEncode(tags ?? (jsonDecode(cur.tagsJson) as List).map((e) => e.toString()).toList())),
    );
    await _db.insertStudy(data);
    return StudyItem(
      id: id,
      title: title ?? cur.title,
      progress: (progress ?? cur.progress).toDouble(),
      tags: tags ?? (jsonDecode(cur.tagsJson) as List).map((e) => e.toString()).toList(),
      lastActivity: now,
    );
  }

  @override
  Future<void> delete(String id) => _db.deleteStudy(id);
}
