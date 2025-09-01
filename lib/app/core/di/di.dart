import 'package:flutter_riverpod/flutter_riverpod.dart';

// Auth
import 'package:studymate_ai_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:studymate_ai_app/features/auth/data/repositories/fake_auth_repository.dart';
import 'package:studymate_ai_app/features/auth/data/repositories/firebase_auth_repository.dart';

// Study
import 'package:studymate_ai_app/features/study/domain/repositories/study_repository.dart';
import 'package:studymate_ai_app/features/study/data/repositories/fake_study_repository.dart';
import 'package:studymate_ai_app/features/study/data/repositories/local_study_repository.dart';

// Chat
import 'package:studymate_ai_app/features/chat/domain/repositories/chat_repository.dart';
import 'package:studymate_ai_app/features/chat/data/repositories/fake_chat_repository.dart';
import 'package:studymate_ai_app/app/core/di/firebase_availability.dart';

/// Auth DI

const bool _kUseFirebaseAuth = bool.fromEnvironment(
  'USE_FIREBASE_AUTH',
  defaultValue: true,
);

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final firebaseReady = ref.watch(firebaseAvailableProvider);
  final useReal = _kUseFirebaseAuth && firebaseReady;
  return useReal ? FirebaseAuthRepository() : FakeAuthRepository();
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
