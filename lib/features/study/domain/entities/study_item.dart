import 'package:freezed_annotation/freezed_annotation.dart';

part 'study_item.freezed.dart';
part 'study_item.g.dart';

@freezed
abstract class StudyItem with _$StudyItem {
  const factory StudyItem({
    required String id,
    required String title,
    @Default(0.0) double progress, // 0.0 ~ 1.0
    required DateTime lastActivity,
    @Default(<String>[]) List<String> tags,
  }) = _StudyItem;

  factory StudyItem.fromJson(Map<String, dynamic> json) => _$StudyItemFromJson(json);
}
