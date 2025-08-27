import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:studymate_ai_app/features/auth/presentation/pages/login_page.dart';
import 'package:studymate_ai_app/features/home/presentation/pages/home_page.dart';
import 'package:studymate_ai_app/app/core/routing/auth_gate.dart';
import 'package:studymate_ai_app/features/home/presentation/pages/home_page.dart';
import 'package:studymate_ai_app/features/study/presentation/pages/study_list_page.dart';
import 'package:studymate_ai_app/app/core/routing/auth_gate.dart';
import 'package:studymate_ai_app/features/home/presentation/pages/home_page.dart';

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
        pageBuilder: (context, state) => const MaterialPage(child: HomePage()),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        pageBuilder: (context, state) =>
            const MaterialPage(child: AuthGate(child: HomePage())),
      ),
      GoRoute(
        path: '/study',
        name: 'study',
        pageBuilder: (context, state) =>
            const MaterialPage(child: AuthGate(child: StudyListPage())),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        pageBuilder: (context, state) =>
            const MaterialPage(child: AuthGate(child: HomePage())),
      ),
    ],
  );
});
