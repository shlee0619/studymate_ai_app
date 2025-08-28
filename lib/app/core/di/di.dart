import 'package:flutter_riverpod/flutter_riverpod.dart';

// Auth
import 'package:studymate_ai_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:studymate_ai_app/features/auth/data/repositories/fake_auth_repository.dart';

// Study
import 'package:studymate_ai_app/features/study/domain/repositories/study_repository.dart';
import 'package:studymate_ai_app/features/study/data/repositories/fake_study_repository.dart';

/// Auth DI
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return FakeAuthRepository();
});

/// Study DI
final studyRepositoryProvider = Provider<StudyRepository>((ref) {
  return FakeStudyRepository();
});
