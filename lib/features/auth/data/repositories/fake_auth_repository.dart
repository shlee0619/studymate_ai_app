import 'dart:async';
import 'package:studymate_ai_app/features/auth/domain/entities/user.dart';
import 'package:studymate_ai_app/features/auth/domain/repositories/auth_repository.dart';

class FakeAuthRepository implements AuthRepository {
  User? _current;

  @override
  Future<User> login({required String email, required String password}) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
    if (email.isEmpty || password.isEmpty) {
      throw Exception('이메일/비밀번호를 입력하세요.');
    }
    _current = User(id: 'u1', name: email.split('@').first);
    return _current!;
  }

  @override
  Future<User?> me() async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return _current;
  }

  @override
  Future<void> logout() async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    _current = null;
  }
}
