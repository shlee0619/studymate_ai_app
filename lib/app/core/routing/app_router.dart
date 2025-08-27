import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:studymate_ai_app/features/auth/presentation/pages/login_page.dart';
import 'package:studymate_ai_app/features/home/presentation/pages/home_page.dart';
import 'package:studymate_ai_app/app/core/routing/auth_gate.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        name: 'login',
        pageBuilder: (context, state) => const MaterialPage(child: LoginPage()),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        pageBuilder: (context, state) =>
            const MaterialPage(child: AuthGate(child: HomePage())),
      ),
      // /study는 나중 슬라이스에서 추가
    ],
  );
});
