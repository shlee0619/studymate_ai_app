import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeControllerProvider =
    StateNotifierProvider<ThemeController, ThemeMode>(
      (ref) => ThemeController()..load(), // 앱 시작 시 저장값 읽어오기
    );

class ThemeController extends StateNotifier<ThemeMode> {
  ThemeController() : super(ThemeMode.system);

  static const _key = 'themeMode'; // 'light' | 'dark' | 'system'

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) return;
    state = _decode(raw);
  }

  Future<void> set(ThemeMode mode) async {
    state = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, _encode(mode));
  }

  Future<void> toggleDark(bool dark) =>
      set(dark ? ThemeMode.dark : ThemeMode.light);

  String _encode(ThemeMode m) => switch (m) {
    ThemeMode.light => 'light',
    ThemeMode.dark => 'dark',
    ThemeMode.system => 'system',
  };

  ThemeMode _decode(String s) => switch (s) {
    'light' => ThemeMode.light,
    'dark' => ThemeMode.dark,
    _ => ThemeMode.system,
  };
}
