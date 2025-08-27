import 'package:flutter_riverpod/flutter_riverpod.dart';

// Auth
import 'package:studymate_ai_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:studymate_ai_app/features/auth/data/repositories/fake_auth_repository.dart';

// Study
import 'package:studymate_ai_app/features/study/domain/repositories/study_repository.dart';
import 'package:studymate_ai_app/features/study/data/repositories/fake_study_repository.dart';
import 'package:studymate_ai_app/features/study/data/repositories/local_study_repository.dart';

// Chat
import 'package:studymate_ai_app/features/chat/domain/repositories/chat_repository.dart';
import 'package:studymate_ai_app/features/chat/data/repositories/fake_chat_repository.dart';

/// Auth DI

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return FakeAuthRepository();
});

/// Study DI
final studyRepositoryProvider = Provider<StudyRepository>((ref) {
  // Switch between implementations as needed.
  // return FakeStudyRepository();
  return ref.watch(localStudyRepositoryProvider);
});

/// Chat DI
final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  return FakeChatRepository();
});
