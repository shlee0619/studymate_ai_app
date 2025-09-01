import 'dart:async';

import 'package:studymate_ai_app/features/study/domain/entities/study_item.dart';
import 'package:studymate_ai_app/features/study/domain/repositories/study_repository.dart';

class FakeStudyRepository implements StudyRepository {
  final List<StudyItem> _items = [];
  int _counter = 1;

  FakeStudyRepository() {
    final now = DateTime.now();
    _items.addAll([
      StudyItem(
        id: 's${_counter++}',
        title: '토익 어휘',
        progress: 0.25,
        lastActivity: now.subtract(const Duration(days: 1)),
        tags: const ['영어', '리딩'],
      ),
      StudyItem(
        id: 's${_counter++}',
        title: '수학 미적분',
        progress: 0.6,
        lastActivity: now.subtract(const Duration(hours: 6)),
        tags: const ['수학'],
      ),
      StudyItem(
        id: 's${_counter++}',
        title: '한국사 근현대사',
        progress: 0.9,
        lastActivity: now.subtract(const Duration(days: 3)),
        tags: const ['한국사', '암기'],
      ),
    ]);
  }

  @override
  Future<List<StudyItem>> fetchAll() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return List.unmodifiable(_items);
  }

  @override
  Future<StudyItem> create({
    required String title,
    double progress = 0.0,
    List<String> tags = const [],
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    final now = DateTime.now();
    final item = StudyItem(
      id: 's${_counter++}',
      title: title,
      progress: progress.clamp(0.0, 1.0).toDouble(),
      lastActivity: now,
      tags: List.unmodifiable(tags),
    );
    _items.add(item);
    return item;
  }

  @override
  Future<StudyItem> update({
    required String id,
    String? title,
    double? progress,
    List<String>? tags,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    final idx = _items.indexWhere((e) => e.id == id);
    if (idx == -1) throw Exception('해당 항목을 찾을 수 없습니다.');
    final now = DateTime.now();
    final cur = _items[idx];
    final updated = cur.copyWith(
      title: title,
      progress: progress?.clamp(0.0, 1.0).toDouble(),
      tags: tags,
      lastActivity: now,
    );
    _items[idx] = updated;
    return updated;
  }

  @override
  Future<void> delete(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    _items.removeWhere((e) => e.id == id);
  }
}

