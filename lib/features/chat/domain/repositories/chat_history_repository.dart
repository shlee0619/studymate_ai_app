import 'package:studymate_ai_app/features/chat/domain/entities/chat_message.dart';

abstract interface class ChatHistoryRepository {
  Stream<List<ChatMessage>> watch({String conversationId = 'default'});
  Future<void> add(ChatMessage message, {String conversationId = 'default'});
  Future<void> clear({String conversationId = 'default'});
}

