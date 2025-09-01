import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// pages
import 'package:studymate_ai_app/features/auth/presentation/pages/login_page.dart';
import 'package:studymate_ai_app/features/home/presentation/pages/home_page.dart';
import 'package:studymate_ai_app/features/settings/presentation/pages/settings_page.dart';
import 'package:studymate_ai_app/features/study/presentation/pages/study_list_page.dart';
import 'package:studymate_ai_app/features/study/presentation/pages/study_detail_page.dart';
import 'package:studymate_ai_app/features/study/presentation/pages/study_edit_page.dart';
import 'package:studymate_ai_app/features/chat/presentation/pages/chat_page.dart';

// state
import 'package:studymate_ai_app/features/auth/presentation/providers/auth_notifier.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const _AuthGate(child: HomePage()),
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const _AuthGate(child: SettingsPage()),
      ),
      GoRoute(
        path: '/chat',
        name: 'chat',
        builder: (context, state) => const _AuthGate(child: ChatPage()),
      ),
      GoRoute(
        path: '/study',
        name: 'study',
        builder: (context, state) => const _AuthGate(child: StudyListPage()),
        routes: [
          GoRoute(
            path: 'new',
            name: 'studyNew',
            builder: (context, state) =>
                const _AuthGate(child: StudyEditPage()),
          ),
          GoRoute(
            path: ':id',
            name: 'studyDetail',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return _AuthGate(child: StudyDetailPage(id: id));
            },
            routes: [
              GoRoute(
                path: 'edit',
                name: 'studyEdit',
                builder: (context, state) {
                  final id = state.pathParameters['id']!;
                  return _AuthGate(child: StudyEditPage(id: id));
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
});

class _AuthGate extends ConsumerWidget {
  const _AuthGate({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authNotifierProvider);
    return auth.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) context.go('/');
        });
        return const SizedBox.shrink();
      },
      data: (user) {
        if (user == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) context.go('/');
          });
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return child;
      },
    );
  }
}
