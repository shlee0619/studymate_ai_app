// lib/features/home/presentation/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:studymate_ai_app/features/auth/presentation/providers/auth_notifier.dart';

/// 로그인 이후 진입하는 홈 화면.
/// - 상단에 사용자 인사말 표시
/// - 우상단 Study / Settings 이동
/// - 우상단 로그아웃 버튼 (세션 종료 후 로그인 화면으로 이동)
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authNotifierProvider);

    return auth.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(
        appBar: AppBar(title: const Text('오류')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('오류가 발생했습니다: $e'),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () =>
                    ref.read(authNotifierProvider.notifier).checkSession(),
                child: const Text('다시 시도'),
              ),
            ],
          ),
        ),
      ),
      data: (user) {
        // 가드를 쓰면 일반적으로 null이 오지 않지만, 안전하게 처리합니다.
        final userName = user?.name ?? '사용자';
        return Scaffold(
          appBar: AppBar(
            title: Text('안녕하세요, $userName'),
            actions: [
              TextButton(
                onPressed: () => context.go('/study'),
                child: const Text('Study'),
              ),
              TextButton(
                onPressed: () => context.go('/settings'),
                child: const Text('Settings'),
              ),
              IconButton(
                tooltip: '로그아웃',
                icon: const Icon(Icons.logout),
                onPressed: () async {
                  await ref.read(authNotifierProvider.notifier).logout();
                  if (context.mounted) context.go('/'); // 로그인 화면으로 이동
                },
              ),
            ],
          ),
          body: const Center(
            child: Text(
              '홈 화면입니다.\n상단 로그아웃 버튼을 눌러 세션을 종료할 수 있습니다.',
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}
