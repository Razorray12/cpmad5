import '../../core/models/message.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/local/local_chat_datasource.dart';

/// Реализация репозитория чата.
class ChatRepositoryImpl implements ChatRepository {
  final LocalChatDataSource _localDataSource;

  ChatRepositoryImpl(this._localDataSource);

  @override
  Future<List<Message>> getMessages() {
    return _localDataSource.getMessages();
  }

  @override
  Future<List<Message>> getMessagesForRoom(String roomId) async {
    // Для простой реализации возвращаем все сообщения
    return _localDataSource.getMessages();
  }

  @override
  Future<Message> sendMessage(Message message) {
    return _localDataSource.sendMessage(message);
  }

  @override
  Future<void> deleteMessage(String id) {
    return _localDataSource.deleteMessage(id);
  }

  @override
  Future<List<Message>> getMessagesForPeriod(
    DateTime startDate,
    DateTime endDate,
  ) {
    return _localDataSource.getMessagesForPeriod(startDate, endDate);
  }

  @override
  Stream<List<Message>> watchMessages() {
    return _localDataSource.messagesStream;
  }

  @override
  Stream<List<Message>> watchMessagesForRoom(String roomId) {
    // Для простой реализации возвращаем все сообщения
    return _localDataSource.messagesStream;
  }
}

