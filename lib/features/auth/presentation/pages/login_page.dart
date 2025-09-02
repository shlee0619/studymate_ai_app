import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:studymate_ai_app/features/auth/presentation/providers/auth_notifier.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});
  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _email = TextEditingController(text: 'demo@example.com');
  final _pwd = TextEditingController(text: 'password');

  @override
  void initState() {
    super.initState();
    ref.read(authNotifierProvider.notifier).checkSession();
  }

  @override
  void dispose() {
    _email.dispose();
    _pwd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Riverpod 2.6: ref.listen은 build 내에서 사용해야 합니다.
    ref.listen(authNotifierProvider, (prev, next) {
      next.when(
        data: (user) {
          if (user != null && mounted) context.go('/home');
        },
        error: (e, _) {
          if (mounted) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('오류: $e')));
          }
        },
        loading: () {},
      );
    });
    final authState = ref.watch(authNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('로그인')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _email,
              decoration: const InputDecoration(labelText: '이메일'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _pwd,
              decoration: const InputDecoration(labelText: '비밀번호'),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            authState.when(
              data: (_) => ElevatedButton(
                onPressed: () => ref
                    .read(authNotifierProvider.notifier)
                    .login(_email.text, _pwd.text),
                child: const Text('로그인'),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('오류: $e'),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => ref
                        .read(authNotifierProvider.notifier)
                        .login(_email.text, _pwd.text),
                    child: const Text('다시 시도'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
