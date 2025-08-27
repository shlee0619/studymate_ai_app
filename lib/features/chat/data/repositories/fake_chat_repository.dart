import 'dart:async';

import 'package:studymate_ai_app/features/chat/domain/entities/chat_message.dart';
import 'package:studymate_ai_app/features/chat/domain/repositories/chat_repository.dart';

class FakeChatRepository implements ChatRepository {
  final _controller = StreamController<List<ChatMessage>>.broadcast();
  final List<ChatMessage> _messages = [];

  FakeChatRepository() {
    // Warm-up system prompt
    final now = DateTime.now();
    _messages.add(
      ChatMessage(
        id: now.microsecondsSinceEpoch.toString(),
        role: ChatRole.system,
        text: 'StudyMate AI에 오신 것을 환영합니다! 학습 질문을 입력해 보세요.',
        createdAt: now,
      ),
    );
    _emit();
  }

  void _emit() => _controller.add(List.unmodifiable(_messages));

  @override
  Stream<List<ChatMessage>> watch() => _controller.stream;

  @override
  Future<void> sendUserMessage(String text) async {
    final now = DateTime.now();
    // 1) Append user message
    _messages.add(
      ChatMessage(
        id: now.microsecondsSinceEpoch.toString(),
        role: ChatRole.user,
        text: text.trim(),
        createdAt: now,
      ),
    );
    _emit();

    // 2) Simulate AI response
    await Future<void>.delayed(const Duration(milliseconds: 600));
    final ai = ChatMessage(
      id: (now.microsecondsSinceEpoch + 1).toString(),
      role: ChatRole.assistant,
      text:
          '요약: "${text.trim()}"\n힌트: 핵심 개념을 3가지로 분해해 보세요. 다음엔 어떤 부분을 더 배우고 싶나요?',
      createdAt: DateTime.now(),
    );
    _messages.add(ai);
    _emit();
  }

  @override
  Future<void> clear() async {
    _messages.clear();
    _emit();
  }

  void dispose() {
    _controller.close();
  }
}

