// lib/features/study/presentation/widgets/study_list_item_tile.dart
import 'package:flutter/material.dart';
import 'package:studymate_ai_app/features/study/domain/entities/study_item.dart';

class StudyListItemTile extends StatelessWidget {
  const StudyListItemTile({super.key, required this.item, this.onTap});

  final StudyItem item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.title),
      subtitle: Text(item.lastActivity.toString()),
      trailing: Text('${item.progress}'),
      onTap: onTap,
    );
  }
}
