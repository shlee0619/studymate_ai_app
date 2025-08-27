import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/core/di/di.dart';
import '../../domain/entities/user.dart';

class AuthNotifier extends StateNotifier<AsyncValue<User?>> {
  AuthNotifier(this._read) : super(const AsyncData<User?>(null));
  final Reader _read;

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    try {
      final repo = _read(authRepositoryProvider);
      final user = await repo.login(email: email, password: password);
      state = AsyncData(user);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> logout() async {
    final repo = _read(authRepositoryProvider);
    await repo.logout();
    state = const AsyncData(null);
  }
}

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<User?>>((ref) {
      return AuthNotifier(ref.read);
    });
