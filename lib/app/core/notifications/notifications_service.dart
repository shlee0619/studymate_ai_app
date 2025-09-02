import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class NotificationsService {
  static Future<void> init() async {
    // Supported on Android/iOS/macOS/web. Skip for Windows/Linux.
    final supported = kIsWeb || const {
      TargetPlatform.android,
      TargetPlatform.iOS,
      TargetPlatform.macOS,
    }.contains(defaultTargetPlatform);
    if (!supported) return;

    final messaging = FirebaseMessaging.instance;

    // iOS/macOS permission
    await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    // Android 13+ permission is requested automatically by plugin when needed.

    try {
      final token = await messaging.getToken();
      // ignore: avoid_print
      print('FCM token: $token');
    } catch (_) {
      // ignore token errors on unsupported platforms
    }

    // Foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // ignore: avoid_print
      print('Foreground message: ${message.notification?.title} ${message.notification?.body}');
    });
  }
}
