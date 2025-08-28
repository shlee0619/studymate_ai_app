import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studymate_ai_app/app/core/di/di.dart';
import 'package:studymate_ai_app/features/study/domain/entities/study_item.dart';

class StudyListNotifier extends StateNotifier<AsyncValue<List<StudyItem>>> {
  StudyListNotifier(this._ref) : super(const AsyncLoading());
  final Ref _ref;

  Future<void> load() async {
    try {
      final repo = _ref.read(studyRepositoryProvider);
      final items = await repo.fetchAll();
      state = AsyncData(items);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<StudyItem> create({
    required String title,
    double progress = 0.0,
    List<String> tags = const [],
  }) async {
    final repo = _ref.read(studyRepositoryProvider);
    final created = await repo.create(
      title: title,
      progress: progress,
      tags: tags,
    );
    final cur = state.value ?? const <StudyItem>[];
    state = AsyncData([...cur, created]);
    return created;
  }

  Future<StudyItem> update({
    required String id,
    String? title,
    double? progress,
    List<String>? tags,
  }) async {
    final repo = _ref.read(studyRepositoryProvider);
    final updated = await repo.update(
      id: id,
      title: title,
      progress: progress,
      tags: tags,
    );
    final cur = state.value ?? const <StudyItem>[];
    final idx = cur.indexWhere((e) => e.id == id);
    if (idx == -1) {
      state = AsyncData([...cur, updated]);
    } else {
      final next = [...cur];
      next[idx] = updated;
      state = AsyncData(next);
    }
    return updated;
  }

  Future<void> remove(String id) async {
    final repo = _ref.read(studyRepositoryProvider);
    await repo.delete(id);
    final cur = state.value ?? const <StudyItem>[];
    state = AsyncData(cur.where((e) => e.id != id).toList());
  }

  Future<void> refresh() => load();
}

final studyListProvider =
    StateNotifierProvider<StudyListNotifier, AsyncValue<List<StudyItem>>>(
      (ref) => StudyListNotifier(ref),
    );
