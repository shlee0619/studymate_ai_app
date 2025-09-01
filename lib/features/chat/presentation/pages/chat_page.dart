import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studymate_ai_app/features/chat/presentation/providers/chat_controller.dart';
import 'package:studymate_ai_app/features/chat/presentation/widgets/chat_composer.dart';
import 'package:studymate_ai_app/features/chat/presentation/widgets/message_bubble.dart';

class ChatPage extends ConsumerWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chatControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Chat'),
        actions: [
          IconButton(
            tooltip: '대화 지우기',
            onPressed: () => ref.read(chatControllerProvider.notifier).clear(),
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: state.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('오류: $e')),
              data: (messages) => ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: messages.length,
                itemBuilder: (context, index) => MessageBubble(
                  message: messages[index],
                ),
              ),
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(12),
            child: ChatComposer(
              onSubmit: (text) =>
                  ref.read(chatControllerProvider.notifier).send(text),
              hintText: '예: “이분탐색 시간복잡도 설명해줘”',
            ),
          ),
        ],
      ),
    );
  }
}

