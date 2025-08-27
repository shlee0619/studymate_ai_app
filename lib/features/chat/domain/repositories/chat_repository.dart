import 'package:studymate_ai_app/features/chat/domain/entities/chat_message.dart';

abstract interface class ChatRepository {
  Stream<List<ChatMessage>> watch();
  Future<void> sendUserMessage(String text);
  Future<void> clear();
}

