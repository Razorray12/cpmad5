import 'package:flutter/foundation.dart';
import '../models/message.dart';

class ChatState extends ChangeNotifier {
  final List<Message> _messages = [];
  List<Message> get messages => List.unmodifiable(_messages);

  void send(String text) {
    if (text.trim().isEmpty) return;
    _messages.add(Message(author: 'me', text: text.trim(), timestamp: DateTime.now()));
    notifyListeners();
  }

  void receive(String text) {
    _messages.add(Message(author: 'peer', text: text.trim(), timestamp: DateTime.now()));
    notifyListeners();
  }
}

