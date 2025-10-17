import 'package:flutter/material.dart';
import '../state/chat_state.dart';
import '../models/message.dart';

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
              itemBuilder: (_, i) => _MessageBubble(msg: _state.messages[i]),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _ctrl,
                  decoration: const InputDecoration(
                    hintText: 'Введите сообщение...',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (_) => _send(),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: _send,
                icon: const Icon(Icons.send),
                label: const Text('Отправить'),
              )
            ],
          ),
        )
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

class _MessageBubble extends StatelessWidget {
  final Message msg;
  const _MessageBubble({required this.msg});

  @override
  Widget build(BuildContext context) {
    final isMe = msg.author == 'me';
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue.shade100 : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              msg.text,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              _fmt(msg.timestamp),
              style: TextStyle(fontSize: 10, color: Colors.grey.shade700),
            )
          ],
        ),
      ),
    );
  }

  String _fmt(DateTime dt) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(dt.day)}.${two(dt.month)}.${dt.year} ${two(dt.hour)}:${two(dt.minute)}';
  }
}

