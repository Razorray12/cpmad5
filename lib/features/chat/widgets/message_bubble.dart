import 'package:flutter/material.dart';

import '../../../shared/widgets/date_format.dart';
import '../models/message.dart';

class MessageBubble extends StatelessWidget {
  final Message msg;
  const MessageBubble({super.key, required this.msg});

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
            Text(msg.text, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 4),
            Text(
              formatDateTimeDDMMYYYYHHMM(msg.timestamp),
              style: TextStyle(fontSize: 10, color: Colors.grey.shade700),
            )
          ],
        ),
      ),
    );
  }
}


