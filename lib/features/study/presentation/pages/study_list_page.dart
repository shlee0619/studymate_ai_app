import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/study_list_notifier.dart';

class StudyListPage extends ConsumerWidget {
  const StudyListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(studyListProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('학습 목록')),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('오류: $e')),
        data: (items) => RefreshIndicator(
          onRefresh: () => ref.read(studyListProvider.notifier).load(),
          child: ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (_, i) => ListTile(
              title: Text(items[i].title),
              subtitle: Text(items[i].id),
            ),
          ),
        ),
      ),
    );
  }
}
