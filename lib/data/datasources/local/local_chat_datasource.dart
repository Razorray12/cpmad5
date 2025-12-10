import 'dart:async';
import '../../../core/models/message.dart';

/// Локальный источник данных для чата.
class LocalChatDataSource {
  final List<Message> _messages = [];
  final _messagesController = StreamController<List<Message>>.broadcast();

  /// Стрим сообщений.
  Stream<List<Message>> get messagesStream => _messagesController.stream;

  /// Получить все сообщения.
  Future<List<Message>> getMessages() async {
    return List.unmodifiable(_messages);
  }

  /// Отправить сообщение.
  Future<Message> sendMessage(Message message) async {
    final newMessage = Message(
      id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
      author: message.author,
      text: message.text,
      timestamp: message.timestamp,
      type: message.type,
    );
    _messages.add(newMessage);
    _messagesController.add(List.unmodifiable(_messages));
    return newMessage;
  }

  /// Удалить сообщение.
  Future<void> deleteMessage(String id) async {
    _messages.removeWhere((m) => m.id == id);
    _messagesController.add(List.unmodifiable(_messages));
  }

  /// Получить сообщения за период.
  Future<List<Message>> getMessagesForPeriod(
    DateTime startDate,
    DateTime endDate,
  ) async {
    return _messages
        .where((m) =>
            m.timestamp.isAfter(startDate) && m.timestamp.isBefore(endDate))
        .toList();
  }

  void dispose() {
    _messagesController.close();
  }
}

