import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studymate_ai_app/features/study/presentation/providers/study_stats_provider.dart';

class StatsPage extends ConsumerWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(studyStatsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('학습 통계')),
      body: stats.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('오류: $e')),
        data: (s) => RefreshIndicator(
          onRefresh: () async {
            // Stats derive from studyList; caller should refresh studyList.
          },
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _StatCard(
                title: '총 학습 항목',
                child: Text('${s.total}', style: Theme.of(context).textTheme.headlineMedium),
              ),
              _StatCard(
                title: '평균 진행도',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LinearProgressIndicator(value: s.avgProgress),
                    const SizedBox(height: 8),
                    Text('${(s.avgProgress * 100).toStringAsFixed(1)}%'),
                  ],
                ),
              ),
              _StatCard(
                title: '태그 분포 상위 5',
                child: Column(
                  children: [
                    for (final entry in (s.tagCounts.entries.toList()
                      ..sort((a, b) => b.value.compareTo(a.value))
                    ).take(5))
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            Expanded(child: Text(entry.key)),
                            Text('${entry.value}')
                          ],
                        ),
                      ),
                    if (s.tagCounts.isEmpty) const Text('태그 데이터가 없습니다.'),
                  ],
                ),
              ),
              _StatCard(
                title: '최근 2주 활동',
                child: _ActivityBarChart(data: s.dailyActivity),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.title, required this.child});
  final String title;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }
}

class _ActivityBarChart extends StatelessWidget {
  const _ActivityBarChart({required this.data});
  final Map<DateTime, int> data;

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return const Text('활동 데이터가 없습니다.');
    final entries = data.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    final maxVal = (entries.map((e) => e.value).fold<int>(0, (p, c) => c > p ? c : p)).clamp(1, 999);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (final e in entries)
          Expanded(
            child: Column(
              children: [
                Text('${e.value}', style: const TextStyle(fontSize: 12)),
                const SizedBox(height: 4),
                Container(
                  height: 80 * (e.value / maxVal),
                  width: 10,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 4),
                Text('${e.key.month}/${e.key.day}', style: const TextStyle(fontSize: 11)),
              ],
            ),
          ),
      ],
    );
  }
}

