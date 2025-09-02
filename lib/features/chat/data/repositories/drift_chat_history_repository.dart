import 'package:drift/drift.dart' as d;
import 'package:studymate_ai_app/features/chat/domain/entities/chat_message.dart';
import 'package:studymate_ai_app/features/chat/domain/repositories/chat_history_repository.dart';
import 'package:studymate_ai_app/local/db/app_database.dart';

class DriftChatHistoryRepository implements ChatHistoryRepository {
  DriftChatHistoryRepository(this._db);
  final AppDatabase _db;

  @override
  Stream<List<ChatMessage>> watch({String conversationId = 'default'}) {
    return _db.watchMessages(conversationId).map((rows) => rows
        .map((r) => ChatMessage(
              id: r.id,
              role: switch (r.role) {
                'assistant' => ChatRole.assistant,
                'system' => ChatRole.system,
                _ => ChatRole.user,
              },
              text: r.text_,
              createdAt: DateTime.fromMillisecondsSinceEpoch(r.createdAtMillis),
            ))
        .toList(growable: false));
  }

  @override
  Future<void> add(ChatMessage message, {String conversationId = 'default'}) async {
    final data = ChatMessagesTableCompanion(
      id: d.Value(message.id),
      conversationId: d.Value(conversationId),
      role: d.Value(switch (message.role) {
        ChatRole.user => 'user',
        ChatRole.assistant => 'assistant',
        ChatRole.system => 'system',
      }),
      text_: d.Value(message.text),
      createdAtMillis: d.Value(message.createdAt.millisecondsSinceEpoch),
    );
    await _db.insertMessage(data);
  }

  @override
  Future<void> clear({String conversationId = 'default'}) => _db.clearConversation(conversationId);
}

