import 'dart:async';
import 'package:studymate_ai_app/features/auth/domain/entities/user.dart';
import 'package:studymate_ai_app/features/auth/domain/repositories/auth_repository.dart';

class FakeAuthRepository implements AuthRepository {
  User? _current;
  final _controller = StreamController<User?>.broadcast();

  @override
  Future<User> login({required String email, required String password}) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    if (email.isEmpty || password.isEmpty) {
      throw Exception('이메일과 비밀번호를 입력하세요.');
    }
    _current = User(id: 'u1', name: email.split('@').first);
    _controller.add(_current);
    return _current!;
  }

  @override
  Future<User?> me() async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    return _current;
  }

  @override
  Future<void> logout() async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    _current = null;
    _controller.add(_current);
  }

  @override
  Stream<User?> authStateChanges() => _controller.stream;
}

