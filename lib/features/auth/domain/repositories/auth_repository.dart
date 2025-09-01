import '../entities/user.dart';

abstract interface class AuthRepository {
  Future<User> login({required String email, required String password});
  Future<User?> me();
  Future<void> logout();
  Stream<User?> authStateChanges();
}
