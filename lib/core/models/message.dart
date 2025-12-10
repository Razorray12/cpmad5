/// Бизнес-модель сообщения чата.
class Message {
  final String? id;
  final String author;
  final String text;
  final DateTime timestamp;
  final MessageType type;

  const Message({
    this.id,
    required this.author,
    required this.text,
    required this.timestamp,
    this.type = MessageType.text,
  });

  /// Проверка, отправлено ли сообщение сегодня.
  bool get isToday {
    final now = DateTime.now();
    return timestamp.year == now.year &&
        timestamp.month == now.month &&
        timestamp.day == now.day;
  }

  /// Форматированное время отправки.
  String get formattedTime {
    final hour = timestamp.hour.toString().padLeft(2, '0');
    final minute = timestamp.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  Message copyWith({
    String? id,
    String? author,
    String? text,
    DateTime? timestamp,
    MessageType? type,
  }) {
    return Message(
      id: id ?? this.id,
      author: author ?? this.author,
      text: text ?? this.text,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Message &&
          runtimeType == other.runtimeType &&
          author == other.author &&
          text == other.text &&
          timestamp == other.timestamp;

  @override
  int get hashCode => Object.hash(author, text, timestamp);
}

/// Тип сообщения.
enum MessageType {
  text,
  image,
  file,
  system,
}

