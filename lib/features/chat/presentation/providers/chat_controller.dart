import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studymate_ai_app/app/core/di/di.dart';
import 'package:studymate_ai_app/features/chat/domain/entities/chat_message.dart';

class ChatController extends AsyncNotifier<List<ChatMessage>> {
  StreamSubscription<List<ChatMessage>>? _sub;

  @override
  FutureOr<List<ChatMessage>> build() async {
    final repo = ref.read(chatRepositoryProvider);
    final completer = Completer<List<ChatMessage>>();
    _sub = repo.watch().listen((data) {
      // First event completes the build
      if (!completer.isCompleted) completer.complete(data);
      state = AsyncData(data);
    });
    ref.onDispose(() => _sub?.cancel());
    return completer.future;
  }

  Future<void> send(String text) async {
    if (text.trim().isEmpty) return;
    final repo = ref.read(chatRepositoryProvider);
    await repo.sendUserMessage(text);
  }

  Future<void> clear() async {
    final repo = ref.read(chatRepositoryProvider);
    await repo.clear();
  }
}

final chatControllerProvider = AsyncNotifierProvider<ChatController, List<ChatMessage>>(
  ChatController.new,
);

