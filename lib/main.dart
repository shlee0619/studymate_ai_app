import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/app.dart';
import 'package:studymate_ai_app/app/core/di/prefs.dart';
import 'package:studymate_ai_app/app/core/di/firebase_availability.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:studymate_ai_app/app/core/notifications/notifications_service.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Ensure Firebase is initialized in background isolate if needed.
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase (best effort to avoid breaking when not configured)
  var firebaseReady = false;
  if (kIsWeb) {
    // On web, Firebase requires explicit options. Skip default init.
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      firebaseReady = true;
    } catch (e) {
      // ignore: avoid_print
      print('Firebase init skipped on web (no options): $e');
    }
  } else {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      firebaseReady = true;
    } catch (e) {
      // Fallback: try default initialization (Android/iOS with bundled configs).
      try {
        await Firebase.initializeApp();
        firebaseReady = true;
      } catch (e2) {
        // ignore: avoid_print
        print('Firebase init failed (no options + default): $e / $e2');
      }
    }
  }
  if (firebaseReady) {
    // Register background handler (Android only)
    final isAndroid = !kIsWeb && defaultTargetPlatform == TargetPlatform.android;
    if (isAndroid) {
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    }
    await NotificationsService.init();
  }
  final prefs = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [
        sharedPrefsProvider.overrideWithValue(prefs),
        firebaseAvailableProvider.overrideWithValue(firebaseReady),
      ],
      child: const App(),
    ),
  );
}
