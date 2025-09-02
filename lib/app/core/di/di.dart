import 'package:flutter_riverpod/flutter_riverpod.dart';

// Auth
import 'package:studymate_ai_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:studymate_ai_app/features/auth/data/repositories/fake_auth_repository.dart';
import 'package:studymate_ai_app/features/auth/data/repositories/firebase_auth_repository.dart';

// Study
import 'package:studymate_ai_app/features/study/domain/repositories/study_repository.dart';
import 'package:studymate_ai_app/features/study/data/repositories/local_study_repository.dart';
import 'package:studymate_ai_app/features/study/data/repositories/firestore_study_repository.dart';

// Chat
import 'package:studymate_ai_app/features/chat/domain/repositories/chat_repository.dart';
import 'package:studymate_ai_app/features/chat/data/repositories/fake_chat_repository.dart';
import 'package:studymate_ai_app/features/chat/domain/repositories/chat_history_repository.dart';
import 'package:studymate_ai_app/features/chat/data/repositories/firestore_chat_history_repository.dart';
import 'package:studymate_ai_app/features/chat/data/repositories/in_memory_chat_history_repository.dart';
import 'package:studymate_ai_app/features/chat/domain/services/chat_ai_service.dart';
import 'package:studymate_ai_app/features/chat/data/services/fake_chat_ai_service.dart';
import 'package:studymate_ai_app/features/study/data/repositories/drift_study_repository.dart';
import 'package:studymate_ai_app/features/chat/data/repositories/drift_chat_history_repository.dart';
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
const bool _kUseFirestoreStudy = bool.fromEnvironment(
  'USE_FIRESTORE_STUDY',
  defaultValue: false,
);
const bool _kUseDriftStudy = bool.fromEnvironment('USE_DRIFT_STUDY', defaultValue: false);

final studyRepositoryProvider = Provider<StudyRepository>((ref) {
  final firebaseReady = ref.watch(firebaseAvailableProvider);
  if (_kUseFirestoreStudy && firebaseReady) return FirestoreStudyRepository();
  if (_kUseDriftStudy) return DriftStudyRepository(ref.watch(appDatabaseProvider));
  return ref.watch(localStudyRepositoryProvider);
});

/// Chat DI
final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  return FakeChatRepository();
});

/// Chat history DI
const bool _kUseDriftChat = bool.fromEnvironment('USE_DRIFT_CHAT', defaultValue: false);

final chatHistoryRepositoryProvider = Provider<ChatHistoryRepository>((ref) {
  final firebaseReady = ref.watch(firebaseAvailableProvider);
  if (firebaseReady) return FirestoreChatHistoryRepository();
  if (_kUseDriftChat) return DriftChatHistoryRepository(ref.watch(appDatabaseProvider));
  return InMemoryChatHistoryRepository();
});

/// Chat AI service DI
final chatAiServiceProvider = Provider<ChatAiService>((ref) {
  return FakeChatAiService();
});
