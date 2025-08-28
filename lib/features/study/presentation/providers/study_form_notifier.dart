// lib/features/study/presentation/providers/study_form_notifier.dart
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studymate_ai_app/features/study/domain/entities/study_item.dart';

@immutable
class StudyFormState {
  final String title;
  final double progress;
  final List<String> tags;
  final String? error;

  const StudyFormState({
    this.title = '',
    this.progress = 0.0,
    this.tags = const <String>[],
    this.error,
  });

  bool get isValid => title.trim().isNotEmpty && progress >= 0.0;

  StudyFormState copyWith({
    String? title,
    double? progress,
    List<String>? tags,
    String? error,
  }) {
    return StudyFormState(
      title: title ?? this.title,
      progress: progress ?? this.progress,
      tags: tags ?? this.tags,
      error: error,
    );
  }
}

final studyFormNotifierProvider =
    StateNotifierProvider<StudyFormNotifier, StudyFormState>(
      (ref) => StudyFormNotifier(),
    );

class StudyFormNotifier extends StateNotifier<StudyFormState> {
  StudyFormNotifier() : super(const StudyFormState());

  void setTitle(String v) => state = state.copyWith(title: v, error: null);

  void setProgress(double v) =>
      state = state.copyWith(progress: v, error: null);

  void setTagsFromCsv(String csv) {
    final list = csv
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList(growable: false);
    state = state.copyWith(tags: list, error: null);
  }

  /// 필요 시: 폼으로부터 `StudyItem`을 즉석 생성(신규용)
  StudyItem buildNewEntity() {
    if (!state.isValid) {
      state = state.copyWith(error: '제목을 입력하고 진행도를 확인하십시오.');
      throw StateError('invalid form');
    }
    return StudyItem(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: state.title.trim(),
      progress: state.progress,
      tags: state.tags,
      lastActivity: DateTime.now(),
    );
  }
}
