import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studymate_ai_app/features/study/domain/entities/study_item.dart';
import 'package:studymate_ai_app/features/study/presentation/providers/study_list_notifier.dart';

enum StudySortBy { recent, progressDesc, titleAsc }

class StudyFilter {
  final String query; // 제목 검색
  final Set<String> tags; // 선택된 태그
  final StudySortBy sortBy; // 정렬 기준

  const StudyFilter({
    this.query = '',
    this.tags = const {},
    this.sortBy = StudySortBy.recent,
  });

  StudyFilter copyWith({
    String? query,
    Set<String>? tags,
    StudySortBy? sortBy,
  }) {
    return StudyFilter(
      query: query ?? this.query,
      tags: tags ?? this.tags,
      sortBy: sortBy ?? this.sortBy,
    );
  }
}

final studyFilterProvider =
    StateNotifierProvider<StudyFilterController, StudyFilter>(
      (ref) => StudyFilterController()..load(),
    );

class StudyFilterController extends StateNotifier<StudyFilter> {
  StudyFilterController() : super(const StudyFilter());

  static const _kQuery = 'studyFilter.query';
  static const _kTags = 'studyFilter.tags';
  static const _kSort = 'studyFilter.sort'; // 'recent' | 'progress' | 'title'

  Future<void> load() async {
    final p = await SharedPreferences.getInstance();
    final q = p.getString(_kQuery) ?? '';
    final tags = p.getStringList(_kTags) ?? const <String>[];
    final sRaw = p.getString(_kSort) ?? 'recent';
    final sort = switch (sRaw) {
      'progress' => StudySortBy.progressDesc,
      'title' => StudySortBy.titleAsc,
      _ => StudySortBy.recent,
    };
    state = StudyFilter(query: q, tags: tags.toSet(), sortBy: sort);
  }

  Future<void> _persist() async {
    final p = await SharedPreferences.getInstance();
    await p.setString(_kQuery, state.query);
    await p.setStringList(_kTags, state.tags.toList()..sort());
    final s = switch (state.sortBy) {
      StudySortBy.recent => 'recent',
      StudySortBy.progressDesc => 'progress',
      StudySortBy.titleAsc => 'title',
    };
    await p.setString(_kSort, s);
  }

  Future<void> setQuery(String q) async {
    state = state.copyWith(query: q);
    await _persist();
  }

  Future<void> toggleTag(String tag) async {
    final next = state.tags.contains(tag)
        ? (state.tags.toSet()..remove(tag))
        : (state.tags.toSet()..add(tag));
    state = state.copyWith(tags: next);
    await _persist();
  }

  Future<void> setSort(StudySortBy s) async {
    state = state.copyWith(sortBy: s);
    await _persist();
  }

  Future<void> clear() async {
    state = const StudyFilter();
    await _persist();
  }
}

/// 필터 적용된 목록을 제공
final filteredStudyListProvider = Provider<AsyncValue<List<StudyItem>>>((ref) {
  final list = ref.watch(studyListProvider); // 원본 목록
  final filter = ref.watch(studyFilterProvider); // 필터 상태

  return list.when(
    loading: () => const AsyncLoading(),
    error: (e, st) => AsyncError(e, st),
    data: (items) {
      Iterable<StudyItem> it = items;

      // 1) 제목 검색
      final q = filter.query.trim().toLowerCase();
      if (q.isNotEmpty) {
        it = it.where((s) => s.title.toLowerCase().contains(q));
      }

      // 2) 태그 필터(AND가 아니라 OR: 선택된 태그 중 하나라도 포함)
      if (filter.tags.isNotEmpty) {
        it = it.where((s) => s.tags.any(filter.tags.contains));
      }

      // 3) 정렬
      final list2 = it.toList();
      switch (filter.sortBy) {
        case StudySortBy.recent:
          list2.sort((a, b) => b.lastActivity.compareTo(a.lastActivity));
          break;
        case StudySortBy.progressDesc:
          list2.sort((a, b) => b.progress.compareTo(a.progress));
          break;
        case StudySortBy.titleAsc:
          list2.sort(
            (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
          );
          break;
      }
      return AsyncData(list2);
    },
  );
});
