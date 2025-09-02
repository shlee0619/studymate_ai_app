// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StudyItem _$StudyItemFromJson(Map<String, dynamic> json) => _StudyItem(
  id: json['id'] as String,
  title: json['title'] as String,
  progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
  lastActivity: DateTime.parse(json['lastActivity'] as String),
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
);

Map<String, dynamic> _$StudyItemToJson(_StudyItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'progress': instance.progress,
      'lastActivity': instance.lastActivity.toIso8601String(),
      'tags': instance.tags,
    };
