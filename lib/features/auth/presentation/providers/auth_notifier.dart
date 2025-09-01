import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studymate_ai_app/app/core/di/di.dart';
import 'package:studymate_ai_app/features/auth/domain/entities/user.dart';

class AuthNotifier extends StateNotifier<AsyncValue<User?>> {
  AuthNotifier(this._ref) : super(const AsyncData<User?>(null)) {
    // Subscribe to auth state changes (Firebase or Fake)
    final repo = _ref.read(authRepositoryProvider);
    _sub = repo.authStateChanges().listen(
      (user) => state = AsyncData(user),
      onError: (e, st) => state = AsyncError(e, st),
    );
  }
  final Ref _ref;
  StreamSubscription<User?>? _sub;

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    try {
      final repo = _ref.read(authRepositoryProvider);
      final user = await repo.login(email: email, password: password);
      state = AsyncData(user);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> logout() async {
    final repo = _ref.read(authRepositoryProvider);
    await repo.logout();
    // Stream will emit null; keeping explicit state for immediacy
    state = const AsyncData(null);
  }

  Future<void> checkSession() async {
    final repo = _ref.read(authRepositoryProvider);
    final user = await repo.me();
    state = AsyncData(user);
  }
}

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<User?>>(
      (ref) => AuthNotifier(ref),
    );
