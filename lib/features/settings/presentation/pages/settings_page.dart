import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:studymate_ai_app/features/auth/presentation/providers/auth_notifier.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _SectionTitle('Account'),
          const ListTile(title: Text('Profile')),
          const ListTile(title: Text('Privacy & Security')),
          const SizedBox(height: 16),

          const _SectionTitle('Preferences'),
          const ListTile(title: Text('Dark Mode')),
          const ListTile(title: Text('Notifications')),
          const ListTile(title: Text('Language')),
          const SizedBox(height: 16),

          const _SectionTitle('Study'),
          const ListTile(title: Text('AI Chat Settings')),
          const ListTile(title: Text('Study Preferences')),
          const SizedBox(height: 16),

          const _SectionTitle('Support'),
          const ListTile(title: Text('Help & FAQ')),
          const ListTile(title: Text('Send Feedback')),
          const ListTile(title: Text('About')),
          const SizedBox(height: 24),

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
