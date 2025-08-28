import '../entities/study_item.dart';

abstract interface class StudyRepository {
  Future<List<StudyItem>> fetchAll();

  Future<StudyItem> create({
    required String title,
    double progress,
    List<String> tags,
  });

  Future<StudyItem> update({
    required String id,
    String? title,
    double? progress,
    List<String>? tags,
  });

  Future<void> delete(String id);
}
