class StudyItem {
  final String id;
  final String title;
  final double progress; // 0.0 ~ 1.0
  final DateTime lastActivity;
  final List<String> tags;

  const StudyItem({
    required this.id,
    required this.title,
    required this.progress,
    required this.lastActivity,
    this.tags = const [],
  });

  StudyItem copyWith({
    String? id,
    String? title,
    double? progress,
    DateTime? lastActivity,
    List<String>? tags,
  }) {
    return StudyItem(
      id: id ?? this.id,
      title: title ?? this.title,
      progress: progress ?? this.progress,
      lastActivity: lastActivity ?? this.lastActivity,
      tags: tags ?? this.tags,
    );
  }
}
