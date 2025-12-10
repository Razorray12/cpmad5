import '../../core/models/message.dart';

/// Абстрактный интерфейс репозитория чата.
abstract class ChatRepository {
  /// Получить все сообщения.
  Future<List<Message>> getMessages();

  /// Получить сообщения для конкретного чата/комнаты.
  Future<List<Message>> getMessagesForRoom(String roomId);

  /// Отправить сообщение.
  Future<Message> sendMessage(Message message);

  /// Удалить сообщение.
  Future<void> deleteMessage(String id);

  /// Получить сообщения за период.
  Future<List<Message>> getMessagesForPeriod(
    DateTime startDate,
    DateTime endDate,
  );

  /// Стрим сообщений.
  Stream<List<Message>> watchMessages();

  /// Стрим сообщений для комнаты.
  Stream<List<Message>> watchMessagesForRoom(String roomId);
}

