import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:studymate_ai_app/features/study/presentation/providers/study_list_notifier.dart';
import 'package:studymate_ai_app/features/study/domain/entities/study_item.dart';

class StudyDetailPage extends ConsumerStatefulWidget {
  const StudyDetailPage({super.key, required this.id});
  final String id;

  @override
  ConsumerState<StudyDetailPage> createState() => _StudyDetailPageState();
}

class _StudyDetailPageState extends ConsumerState<StudyDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(studyListProvider.notifier).load());
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(studyListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('학습 상세')),
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
        data: (items) {
          final StudyItem? item = _find(items, widget.id);
          if (item == null) {
            return const Center(child: Text('해당 항목을 찾을 수 없습니다.'));
          }
          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                Text(
                  item.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 12),
                LinearProgressIndicator(value: item.progress),
                const SizedBox(height: 12),
                Text('최근 학습: ${_ymd(item.lastActivity)}'),
                if (item.tags.isNotEmpty) ...[
                  const SizedBox(height: 8),
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
                const SizedBox(height: 24),
                Row(
                  children: [
                    FilledButton.icon(
                      onPressed: () => context.go('/study/${item.id}/edit'),
                      icon: const Icon(Icons.edit),
                      label: const Text('편집'),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton.icon(
                      onPressed: () async {
                        final ok = await showDialog<bool>(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('삭제'),
                            content: const Text('정말 삭제하시겠습니까?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text('취소'),
                              ),
                              FilledButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text('삭제'),
                              ),
                            ],
                          ),
                        );
                        if (ok == true) {
                          await ref
                              .read(studyListProvider.notifier)
                              .remove(item.id);
                          if (context.mounted) context.go('/study');
                        }
                      },
                      icon: const Icon(Icons.delete_outline),
                      label: const Text('삭제'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  StudyItem? _find(List<StudyItem> items, String id) {
    for (final s in items) {
      if (s.id == id) return s;
    }
    return null;
  }

  String _ymd(DateTime d) {
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '${d.year}-$m-$day';
  }
}
