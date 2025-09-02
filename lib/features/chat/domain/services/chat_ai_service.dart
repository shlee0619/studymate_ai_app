abstract interface class ChatAiService {
  Future<String> reply(String userMessage, {String? context});
}

