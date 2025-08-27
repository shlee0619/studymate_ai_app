import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studymate_ai_app/app/core/di/di.dart';
import '../../domain/entities/study_item.dart';

class StudyListNotifier extends StateNotifier<AsyncValue<List<StudyItem>>> {
  StudyListNotifier(this._read) : super(const AsyncLoading()) {
    load();
  }
  final Reader _read;

  Future<void> load() async {
    try {
      final repo = _read(studyRepositoryProvider);
      final items = await repo.fetchList();
      state = AsyncData(items);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final studyListProvider =
    StateNotifierProvider<StudyListNotifier, AsyncValue<List<StudyItem>>>(
      (ref) => StudyListNotifier(ref.read),
    );
