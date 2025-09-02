import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studymate_ai_app/features/study/presentation/providers/study_list_notifier.dart';

class StudyStats {
  final int total;
  final double avgProgress; // 0..1
  final Map<String, int> tagCounts; // tag -> count
  final Map<DateTime, int> dailyActivity; // date(yyyy-mm-dd) -> count

  const StudyStats({
    required this.total,
    required this.avgProgress,
    required this.tagCounts,
    required this.dailyActivity,
  });
}

final studyStatsProvider = Provider<AsyncValue<StudyStats>>((ref) {
  final list = ref.watch(studyListProvider);
  return list.when(
    loading: () => const AsyncLoading(),
    error: (e, st) => AsyncError(e, st),
    data: (items) {
      if (items.isEmpty) {
        return const AsyncData(
          StudyStats(total: 0, avgProgress: 0, tagCounts: {}, dailyActivity: {}),
        );
      }

      final total = items.length;
      final avg = items.map((e) => e.progress).reduce((a, b) => a + b) / total;

      final Map<String, int> tagCounts = {};
      for (final s in items) {
        for (final t in s.tags) {
          tagCounts.update(t, (v) => v + 1, ifAbsent: () => 1);
        }
      }

      DateTime asDate(DateTime dt) => DateTime(dt.year, dt.month, dt.day);
      final Map<DateTime, int> daily = {};
      final now = DateTime.now();
      for (int i = 0; i < 14; i++) {
        final d = asDate(now.subtract(Duration(days: i)));
        daily[d] = 0;
      }
      for (final s in items) {
        final d = asDate(s.lastActivity);
        if (daily.containsKey(d)) daily[d] = (daily[d] ?? 0) + 1;
      }

      return AsyncData(StudyStats(
        total: total,
        avgProgress: avg,
        tagCounts: tagCounts,
        dailyActivity: daily,
      ));
    },
  );
});
