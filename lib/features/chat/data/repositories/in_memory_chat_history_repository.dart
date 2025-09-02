import 'dart:async';

import 'package:studymate_ai_app/features/chat/domain/entities/chat_message.dart';
import 'package:studymate_ai_app/features/chat/domain/repositories/chat_history_repository.dart';

class InMemoryChatHistoryRepository implements ChatHistoryRepository {
  final _controller = StreamController<List<ChatMessage>>.broadcast();
  final Map<String, List<ChatMessage>> _store = {};

  void _emit(String id) => _controller.add(List.unmodifiable(_store[id] ?? const <ChatMessage>[]));

  @override
  Stream<List<ChatMessage>> watch({String conversationId = 'default'}) {
    // Emit current snapshot immediately
    scheduleMicrotask(() => _emit(conversationId));
    return _controller.stream;
  }

  @override
  Future<void> add(ChatMessage message, {String conversationId = 'default'}) async {
    final list = _store.putIfAbsent(conversationId, () => <ChatMessage>[]);
    list.add(message);
    _emit(conversationId);
  }

  @override
  Future<void> clear({String conversationId = 'default'}) async {
    _store[conversationId] = <ChatMessage>[];
    _emit(conversationId);
  }
}

