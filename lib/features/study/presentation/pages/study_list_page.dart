import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:studymate_ai_app/features/study/presentation/providers/study_list_notifier.dart';
import 'package:studymate_ai_app/features/study/presentation/providers/study_filter_provider.dart';
import 'package:studymate_ai_app/features/study/domain/entities/study_item.dart';

class StudyListPage extends ConsumerStatefulWidget {
  const StudyListPage({super.key});

  @override
  ConsumerState<StudyListPage> createState() => _StudyListPageState();
}

class _StudyListPageState extends ConsumerState<StudyListPage> {
  late final TextEditingController _query;

  @override
  void initState() {
    super.initState();
    _query = TextEditingController();
    // 초기 로드 및 저장된 필터 반영
    Future.microtask(() async {
      await ref.read(studyListProvider.notifier).load();
      final q = ref.read(studyFilterProvider).query;
      _query.text = q;
    });
  }

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rawState = ref.watch(studyListProvider); // 원본 목록
    final filtered = ref.watch(filteredStudyListProvider); // 필터 적용 결과
    final filter = ref.watch(studyFilterProvider);

    // 사용 가능한 태그 모음
    final Set<String> availableTags = {
      for (final s in rawState.value ?? const <StudyItem>[]) ...s.tags,
    };

    return Scaffold(
      appBar: AppBar(title: const Text('학습 목록')),
      body: Column(
        children: [
          // ====== 필터 영역 ======
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _query,
                    onChanged: (v) =>
                        ref.read(studyFilterProvider.notifier).setQuery(v),
                    decoration: InputDecoration(
                      hintText: '제목 검색',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: filter.query.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _query.clear();
                                ref
                                    .read(studyFilterProvider.notifier)
                                    .setQuery('');
                              },
                            )
                          : null,
                      border: const OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                DropdownButton<StudySortBy>(
                  value: filter.sortBy,
                  onChanged: (v) {
                    if (v != null) {
                      ref.read(studyFilterProvider.notifier).setSort(v);
                    }
                  },
                  items: const [
                    DropdownMenuItem(
                      value: StudySortBy.recent,
                      child: Text('최신'),
                    ),
                    DropdownMenuItem(
                      value: StudySortBy.progressDesc,
                      child: Text('진행도 높은 순'),
                    ),
                    DropdownMenuItem(
                      value: StudySortBy.titleAsc,
                      child: Text('제목(가나다)'),
                    ),
                  ],
                ),
                const SizedBox(width: 4),
                TextButton(
                  onPressed: () =>
                      ref.read(studyFilterProvider.notifier).clear(),
                  child: const Text('초기화'),
                ),
              ],
            ),
          ),
          // 태그 선택 영역
          if (availableTags.isNotEmpty)
            SizedBox(
              height: 44,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                scrollDirection: Axis.horizontal,
                children: [
                  const SizedBox(width: 4),
                  for (final t in availableTags.toList()..sort())
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ChoiceChip(
                        label: Text(t),
                        selected: filter.tags.contains(t),
                        onSelected: (_) =>
                            ref.read(studyFilterProvider.notifier).toggleTag(t),
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                  const SizedBox(width: 4),
                ],
              ),
            ),

          const Divider(height: 8, thickness: 0.5),

          // ====== 목록 영역 ======
          Expanded(
            child: filtered.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('불러오기 실패: $e'),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () =>
                          ref.read(studyListProvider.notifier).load(),
                      child: const Text('다시 시도'),
                    ),
                  ],
                ),
              ),
              data: (items) => RefreshIndicator(
                onRefresh: () => ref.read(studyListProvider.notifier).refresh(),
                child: items.isEmpty
                    ? const ListTile(
                        title: Text('데이터가 없습니다.'),
                        subtitle: Text('오른쪽 하단에서 추가해 보세요.'),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.all(12),
                        itemCount: items.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return _StudyCard(item: item);
                        },
                      ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/study/new'),
        icon: const Icon(Icons.add),
        label: const Text('추가'),
      ),
    );
  }
}

class _StudyCard extends StatelessWidget {
  const _StudyCard({required this.item});
  final StudyItem item;

  String _ymd(DateTime d) {
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '${d.year}-$m-$day';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => context.go('/study/${item.id}')
        ,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.title, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              LinearProgressIndicator(value: item.progress),
              const SizedBox(height: 8),
              Text('최근 학습: ${_ymd(item.lastActivity)}'),
              if (item.tags.isNotEmpty) ...[
                const SizedBox(height: 4),
                Wrap(
                  spacing: 6,
                  children: item.tags
                      .map(
                        (t) => Chip(
                          label: Text(t),
                          visualDensity: VisualDensity.compact,
                        ),
                      )
                      .toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

