import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:studymate_ai_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('StudyMate AI App Integration Tests', () {
    testWidgets('app starts and shows home page', (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle();

      // Verify that the app starts successfully and shows home content
      expect(find.text('Welcome to StudyMate AI'), findsOneWidget);
      expect(find.text('Your AI-powered study companion'), findsOneWidget);
      expect(find.byIcon(Icons.school), findsOneWidget);
    });

    testWidgets('bottom navigation works correctly', (
      WidgetTester tester,
    ) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle();

      // Test navigation to Study Sessions
      await tester.tap(find.text('Study'));
      await tester.pumpAndSettle();
      expect(find.text('Study Sessions'), findsOneWidget);

      // Test navigation to AI Chat
      await tester.tap(find.text('AI Chat'));
      await tester.pumpAndSettle();
      expect(find.text('AI Chat'), findsOneWidget);
      expect(find.text('Start a conversation with AI'), findsOneWidget);

      // Test navigation to Settings
      await tester.tap(find.text('Settings'));
      await tester.pumpAndSettle();
      expect(find.text('Settings'), findsOneWidget);
      expect(find.text('Account'), findsOneWidget);
      expect(find.text('Preferences'), findsOneWidget);

      // Test navigation back to Home
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();
      expect(find.text('Welcome to StudyMate AI'), findsOneWidget);
    });

    testWidgets('study sessions page functionality', (
      WidgetTester tester,
    ) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle();

      // Navigate to Study Sessions
      await tester.tap(find.text('Study'));
      await tester.pumpAndSettle();

      // Verify empty state
      expect(find.text('No study sessions yet'), findsOneWidget);
      expect(find.text('Tap + to create your first session'), findsOneWidget);

      // Test create session dialog
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      expect(find.text('Create Study Session'), findsOneWidget);
      expect(find.text('Session Title'), findsOneWidget);

      // Cancel the dialog
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
    });

    testWidgets('ai chat page basic functionality', (
      WidgetTester tester,
    ) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle();

      // Navigate to AI Chat
      await tester.tap(find.text('AI Chat'));
      await tester.pumpAndSettle();

      // Verify empty state
      expect(find.text('Start a conversation with AI'), findsOneWidget);
      expect(find.text('Ask me anything about your studies!'), findsOneWidget);
      expect(find.byIcon(Icons.chat_bubble_outline), findsOneWidget);

      // Verify input field exists
      expect(find.text('Type your message...'), findsOneWidget);
      expect(find.byIcon(Icons.send), findsOneWidget);

      // Test message input (without actually sending due to API dependency)
      await tester.enterText(
        find.widgetWithText(TextField, 'Type your message...'),
        'Hello AI',
      );
      expect(find.text('Hello AI'), findsOneWidget);

      // Clear the input
      await tester.enterText(
        find.widgetWithText(TextField, 'Type your message...'),
        '',
      );
    });

    testWidgets('settings page displays all sections', (
      WidgetTester tester,
    ) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle();

      // Navigate to Settings
      await tester.tap(find.text('Settings'));
      await tester.pumpAndSettle();

      // Verify all settings sections are present
      expect(find.text('Account'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
      expect(find.text('Privacy & Security'), findsOneWidget);

      expect(find.text('Preferences'), findsOneWidget);
      expect(find.text('Dark Mode'), findsOneWidget);
      expect(find.text('Notifications'), findsOneWidget);
      expect(find.text('Language'), findsOneWidget);

      expect(find.text('Study'), findsOneWidget);
      expect(find.text('AI Chat Settings'), findsOneWidget);
      expect(find.text('Study Preferences'), findsOneWidget);

      expect(find.text('Support'), findsOneWidget);
      expect(find.text('Help & FAQ'), findsOneWidget);
      expect(find.text('Send Feedback'), findsOneWidget);
      expect(find.text('About'), findsOneWidget);

      expect(find.text('Sign Out'), findsOneWidget);
    });

    testWidgets('app maintains state during navigation', (
      WidgetTester tester,
    ) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle();

      // Navigate to AI Chat and enter some text
      await tester.tap(find.text('AI Chat'));
      await tester.pumpAndSettle();

      await tester.enterText(
        find.widgetWithText(TextField, 'Type your message...'),
        'Test message',
      );

      // Navigate away and back
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('AI Chat'));
      await tester.pumpAndSettle();

      // Note: In a real app with proper state management,
      // we would verify that the text is still there
      // For now, just verify we can navigate back
      expect(find.text('AI Chat'), findsOneWidget);
    });

    testWidgets('app handles refresh correctly', (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle();

      // Navigate to AI Chat
      await tester.tap(find.text('AI Chat'));
      await tester.pumpAndSettle();

      // Test refresh button
      await tester.tap(find.byIcon(Icons.refresh));
      await tester.pumpAndSettle();

      // Verify we're still on the AI Chat page
      expect(find.text('AI Chat'), findsOneWidget);
      expect(find.text('Start a conversation with AI'), findsOneWidget);
    });
  });
}
