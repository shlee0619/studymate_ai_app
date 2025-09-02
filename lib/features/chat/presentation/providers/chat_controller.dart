import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studymate_ai_app/app/core/di/di.dart';
import 'package:studymate_ai_app/features/chat/domain/entities/chat_message.dart';

class ChatController extends AsyncNotifier<List<ChatMessage>> {
  StreamSubscription<List<ChatMessage>>? _sub;

  @override
  FutureOr<List<ChatMessage>> build() async {
    final history = ref.read(chatHistoryRepositoryProvider);
    final completer = Completer<List<ChatMessage>>();
    _sub = history.watch().listen((data) {
      if (!completer.isCompleted) completer.complete(data);
      state = AsyncData(data);
    }, onError: (e, st) => state = AsyncError(e, st));
    ref.onDispose(() => _sub?.cancel());
    return completer.future;
  }

  Future<void> send(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;
    final history = ref.read(chatHistoryRepositoryProvider);
    final ai = ref.read(chatAiServiceProvider);
    final now = DateTime.now();
    await history.add(ChatMessage(
      id: now.microsecondsSinceEpoch.toString(),
      role: ChatRole.user,
      text: trimmed,
      createdAt: now,
    ));
    final reply = await ai.reply(trimmed);
    await history.add(ChatMessage(
      id: (now.microsecondsSinceEpoch + 1).toString(),
      role: ChatRole.assistant,
      text: reply,
      createdAt: DateTime.now(),
    ));
  }

  Future<void> clear() async {
    final history = ref.read(chatHistoryRepositoryProvider);
    await history.clear();
  }
}

final chatControllerProvider = AsyncNotifierProvider<ChatController, List<ChatMessage>>(
  ChatController.new,
);
