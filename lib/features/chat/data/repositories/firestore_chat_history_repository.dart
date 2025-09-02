import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:studymate_ai_app/features/chat/domain/entities/chat_message.dart';
import 'package:studymate_ai_app/features/chat/domain/repositories/chat_history_repository.dart';

class FirestoreChatHistoryRepository implements ChatHistoryRepository {
  FirestoreChatHistoryRepository({FirebaseFirestore? firestore, fb_auth.FirebaseAuth? auth})
      : _db = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? fb_auth.FirebaseAuth.instance;

  final FirebaseFirestore _db;
  final fb_auth.FirebaseAuth _auth;

  String get _uid => _auth.currentUser?.uid ?? (throw StateError('로그인이 필요합니다.'));

  CollectionReference<Map<String, dynamic>> _messagesCol(String convoId) =>
      _db.collection('users').doc(_uid).collection('chats').doc(convoId).collection('messages');

  ChatMessage _fromDoc(DocumentSnapshot<Map<String, dynamic>> d) {
    final data = d.data() ?? <String, dynamic>{};
    final roleStr = (data['role'] as String?) ?? 'user';
    final role = switch (roleStr) {
      'assistant' => ChatRole.assistant,
      'system' => ChatRole.system,
      _ => ChatRole.user,
    };
    return ChatMessage(
      id: d.id,
      role: role,
      text: (data['text'] as String?) ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> _toMap(ChatMessage m) => {
        'role': switch (m.role) {
          ChatRole.user => 'user',
          ChatRole.assistant => 'assistant',
          ChatRole.system => 'system',
        },
        'text': m.text,
        'createdAt': Timestamp.fromDate(m.createdAt),
      };

  @override
  Stream<List<ChatMessage>> watch({String conversationId = 'default'}) {
    return _messagesCol(conversationId)
        .orderBy('createdAt')
        .snapshots()
        .map((snap) => snap.docs.map(_fromDoc).toList(growable: false));
  }

  @override
  Future<void> add(ChatMessage message, {String conversationId = 'default'}) async {
    await _messagesCol(conversationId).add(_toMap(message));
  }

  @override
  Future<void> clear({String conversationId = 'default'}) async {
    final batch = _db.batch();
    final qs = await _messagesCol(conversationId).get();
    for (final d in qs.docs) {
      batch.delete(d.reference);
    }
    await batch.commit();
  }
}

