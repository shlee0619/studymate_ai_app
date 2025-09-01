import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/app.dart';
import 'package:studymate_ai_app/app/core/di/prefs.dart';
import 'package:studymate_ai_app/app/core/di/firebase_availability.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase (best effort to avoid breaking when not configured)
  var firebaseReady = false;
  try {
    // Preferred: use FlutterFire-generated options for all platforms.
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
