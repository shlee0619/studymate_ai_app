import 'package:flutter/material.dart';

class ChatComposer extends StatefulWidget {
  const ChatComposer({super.key, required this.onSubmit, this.hintText});
  final Future<void> Function(String text) onSubmit;
  final String? hintText;

  @override
  State<ChatComposer> createState() => _ChatComposerState();
}

class _ChatComposerState extends State<ChatComposer> {
  final _controller = TextEditingController();
  bool _sending = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleSend() async {
    final text = _controller.text.trim();
    if (text.isEmpty || _sending) return;
    setState(() => _sending = true);
    try {
      await widget.onSubmit(text);
      if (mounted) _controller.clear();
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            minLines: 1,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: widget.hintText ?? '질문을 입력하세요...',
              border: const OutlineInputBorder(),
              isDense: true,
            ),
            onSubmitted: (_) => _handleSend(),
          ),
        ),
        const SizedBox(width: 8),
        FilledButton.icon(
          onPressed: _sending ? null : _handleSend,
          icon: const Icon(Icons.send),
          label: const Text('보내기'),
        ),
      ],
    );
  }
}

