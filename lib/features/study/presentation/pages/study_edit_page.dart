import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:studymate_ai_app/features/study/presentation/providers/study_list_notifier.dart';
import 'package:studymate_ai_app/features/study/domain/entities/study_item.dart';

class StudyEditPage extends ConsumerStatefulWidget {
  const StudyEditPage({super.key, this.id});
  final String? id; // null이면 생성 모드

  @override
  ConsumerState<StudyEditPage> createState() => _StudyEditPageState();
}

class _StudyEditPageState extends ConsumerState<StudyEditPage> {
  final _title = TextEditingController();
  final _tags = TextEditingController();
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(studyListProvider.notifier).load());
  }

  @override
  void dispose() {
    _title.dispose();
    _tags.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(studyListProvider);

    // 편집 모드면 기존 값 주입
    StudyItem? existing;
    if (widget.id != null) {
      final items = state.value;
      if (items != null) {
        existing = items.firstWhere(
          (e) => e.id == widget.id,
          orElse: () => StudyItem(
            id: '',
            title: '',
            progress: 0.0,
            lastActivity: DateTime.fromMillisecondsSinceEpoch(0),
          ),
        );
      }
      if (existing != null && existing.id.isNotEmpty && _title.text.isEmpty) {
        _title.text = existing.title;
        _progress = existing.progress;
        _tags.text = existing.tags.join(', ');
      }
    }

    final isCreate = widget.id == null;

    return Scaffold(
      appBar: AppBar(title: Text(isCreate ? '학습 추가' : '학습 편집')),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('불러오기 실패: $e')),
        data: (_) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextField(
              controller: _title,
              decoration: const InputDecoration(
                labelText: '제목',
                hintText: '예) 영어 독해',
              ),
            ),
            const SizedBox(height: 16),
            Text('진행도: ${(_progress * 100).round()}%'),
            Slider(
              value: _progress,
              onChanged: (v) => setState(() => _progress = v),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _tags,
              decoration: const InputDecoration(
                labelText: '태그(쉼표로 구분)',
                hintText: '예) 영어, 리딩',
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () async {
                final title = _title.text.trim();
                if (title.isEmpty) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('제목을 입력하세요.')));
                  return;
                }
                final tags = _tags.text
                    .split(',')
                    .map((s) => s.trim())
                    .where((s) => s.isNotEmpty)
                    .toList();

                if (isCreate) {
                  final created = await ref
                      .read(studyListProvider.notifier)
                      .create(title: title, progress: _progress, tags: tags);
                  if (context.mounted) context.go('/study/${created.id}');
                } else {
                  final id = widget.id!;
                  await ref
                      .read(studyListProvider.notifier)
                      .update(
                        id: id,
                        title: title,
                        progress: _progress,
                        tags: tags,
                      );
                  if (context.mounted) context.go('/study/$id');
                }
              },
              icon: const Icon(Icons.save),
              label: Text(isCreate ? '추가' : '저장'),
            ),
          ],
        ),
      ),
    );
  }
}
