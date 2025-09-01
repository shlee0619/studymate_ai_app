import 'package:firebase_auth/firebase_auth.dart';

String mapFirebaseAuthError(Object error) {
  if (error is FirebaseAuthException) {
    switch (error.code) {
      case 'invalid-email':
        return '올바른 이메일 형식이 아닙니다.';
      case 'user-disabled':
        return '해당 계정이 비활성화되었습니다.';
      case 'user-not-found':
      case 'wrong-password':
        return '이메일 또는 비밀번호가 올바르지 않습니다.';
      case 'too-many-requests':
        return '요청이 너무 많습니다. 잠시 후 다시 시도하세요.';
      case 'operation-not-allowed':
        return '이 제공자의 로그인이 비활성화되어 있습니다.';
      default:
        return error.message ?? '인증 중 오류가 발생했습니다.';
    }
  }
  return '인증 중 알 수 없는 오류가 발생했습니다.';
}

