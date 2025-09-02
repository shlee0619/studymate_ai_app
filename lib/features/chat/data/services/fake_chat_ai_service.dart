import 'dart:async';

import 'package:studymate_ai_app/features/chat/domain/services/chat_ai_service.dart';

class FakeChatAiService implements ChatAiService {
  @override
  Future<String> reply(String userMessage, {String? context}) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return '요약: "${userMessage.trim()}"\n힌트: 핵심 키워드를 나열해 보세요.';
  }
}

