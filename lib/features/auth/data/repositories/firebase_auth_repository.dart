import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:studymate_ai_app/features/auth/domain/entities/user.dart' as ent;
import 'package:studymate_ai_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:studymate_ai_app/features/auth/data/mappers/firebase_auth_error_mapper.dart';

class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository({fb.FirebaseAuth? auth}) : _auth = auth ?? fb.FirebaseAuth.instance;
  final fb.FirebaseAuth _auth;

  ent.User _map(fb.User u) => ent.User(id: u.uid, name: u.displayName ?? (u.email ?? '사용자'));

  @override
  Future<ent.User> login({required String email, required String password}) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
      final u = cred.user;
      if (u == null) {
        throw StateError('로그인 결과 사용자 정보가 없습니다.');
      }
      return _map(u);
    } catch (e) {
      throw Exception(mapFirebaseAuthError(e));
    }
  }

  @override
  Future<ent.User?> me() async {
    final u = _auth.currentUser;
    return u == null ? null : _map(u);
  }

  @override
  Future<void> logout() async {
    await _auth.signOut();
  }
}
