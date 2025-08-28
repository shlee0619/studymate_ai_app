import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:studymate_ai_app/app/core/theme/theme_controller.dart';
import 'package:studymate_ai_app/features/auth/presentation/providers/auth_notifier.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeControllerProvider);
    final isDark = mode == ThemeMode.dark;
    final isLight = mode == ThemeMode.light;
    final isSystem = mode == ThemeMode.system;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 섹션: Account
          const _SectionTitle('Account'),
          const ListTile(title: Text('Profile')),
          const ListTile(title: Text('Privacy & Security')),
          const SizedBox(height: 16),

          // 섹션: Preferences
          const _SectionTitle('Preferences'),

          // 다크 모드 - 빠른 토글
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: isDark,
            onChanged: (v) =>
                ref.read(themeControllerProvider.notifier).toggleDark(v),
            subtitle: const Text('빠르게 라이트/다크를 전환합니다.'),
          ),

          // 세부 선택(라이트/다크/시스템)
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Theme Mode 상세',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                RadioListTile<bool>(
                  title: const Text('System'),
                  value: true,
                  groupValue: isSystem,
                  onChanged: (_) => ref
                      .read(themeControllerProvider.notifier)
                      .set(ThemeMode.system),
                ),
                RadioListTile<bool>(
                  title: const Text('Light'),
                  value: true,
                  groupValue: isLight,
                  onChanged: (_) => ref
                      .read(themeControllerProvider.notifier)
                      .set(ThemeMode.light),
                ),
                RadioListTile<bool>(
                  title: const Text('Dark'),
                  value: true,
                  groupValue: isDark,
                  onChanged: (_) => ref
                      .read(themeControllerProvider.notifier)
                      .set(ThemeMode.dark),
                ),
              ],
            ),
          ),

          const ListTile(title: Text('Notifications')),
          const ListTile(title: Text('Language')),
          const SizedBox(height: 16),

          // 섹션: Study
          const _SectionTitle('Study'),
          const ListTile(title: Text('AI Chat Settings')),
          const ListTile(title: Text('Study Preferences')),
          const SizedBox(height: 16),

          // 섹션: Support
          const _SectionTitle('Support'),
          const ListTile(title: Text('Help & FAQ')),
          const ListTile(title: Text('Send Feedback')),
          const ListTile(title: Text('About')),
          const SizedBox(height: 24),

          // Sign out
          ElevatedButton(
            onPressed: () async {
              await ref.read(authNotifierProvider.notifier).logout();
              if (context.mounted) context.go('/');
            },
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: Theme.of(context).textTheme.titleLarge),
    );
  }
}
