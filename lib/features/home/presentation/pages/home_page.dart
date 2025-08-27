import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:studymate_ai_app/features/auth/presentation/providers/auth_notifier.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authNotifierProvider);
    final userName = auth.value?.name ?? '게스트';

    return Scaffold(
      appBar: AppBar(
        title: Text('안녕하세요, $userName'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: '로그아웃',
            onPressed: () async {
              await ref.read(authNotifierProvider.notifier).logout();
              if (context.mounted) context.go('/'); // 로그인 화면으로
            },
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/study'),
          child: const Text('학습 목록 보기'),
        ),
      ),
    );
  }
}
