import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/auth/data/repositories/fake_auth_repository.dart';
import '../../../features/auth/domain/repositories/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  // 초기에는 Fake로 시작 → 이후 실제 구현으로 교체
  return FakeAuthRepository();
});
