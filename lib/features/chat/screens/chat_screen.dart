import 'package:flutter/material.dart';
import '../state/chat_state.dart';
import '../widgets/chat_input_bar.dart';
import '../widgets/message_bubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatState _state = ChatState();
  final TextEditingController _ctrl = TextEditingController();
  final ScrollController _scroll = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: AnimatedBuilder(
            animation: _state,
            builder: (_, __) => ListView.builder(
              controller: _scroll,
              padding: const EdgeInsets.all(12),
              itemCount: _state.messages.length,
              itemBuilder: (_, i) => MessageBubble(msg: _state.messages[i]),
            ),
          ),
        ),
        ChatInputBar(controller: _ctrl, onSend: _send)
      ],
    );
  }

  void _send() {
    final text = _ctrl.text.trim();
    if (text.isEmpty) return;
    _state.send(text);
    _ctrl.clear();
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scroll.hasClients) {
        _scroll.jumpTo(_scroll.position.maxScrollExtent);
      }
    });
  }
}

// MessageBubble вынесен в ../widgets/message_bubble.dart

