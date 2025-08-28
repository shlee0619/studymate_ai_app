import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:studymate_ai_app/features/study/presentation/providers/study_list_notifier.dart';
import 'package:studymate_ai_app/features/study/domain/entities/study_item.dart';

class StudyListPage extends ConsumerStatefulWidget {
  const StudyListPage({super.key});

  @override
  ConsumerState<StudyListPage> createState() => _StudyListPageState();
}

class _StudyListPageState extends ConsumerState<StudyListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(studyListProvider.notifier).load());
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(studyListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('학습 목록')),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('불러오기 실패: $e'),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => ref.read(studyListProvider.notifier).load(),
                child: const Text('다시 시도'),
              ),
            ],
          ),
        ),
        data: (items) => RefreshIndicator(
          onRefresh: () => ref.read(studyListProvider.notifier).refresh(),
          child: items.isEmpty
              ? const ListTile(
                  title: Text('항목이 없습니다.'),
                  subtitle: Text('우측 하단에서 추가해 보세요.'),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/study/new'), // 추가 폼으로 이동
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
        onTap: () => context.go('/study/${item.id}'), // 상세로 이동
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
