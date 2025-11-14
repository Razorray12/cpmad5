import 'package:mobx/mobx.dart';
import '../models/message.dart';

part 'chat_state.g.dart';

class ChatState = _ChatState with _$ChatState;

abstract class _ChatState with Store {
  @observable
  ObservableList<Message> messages = ObservableList<Message>();

  @action
  void send(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;
    messages.add(
      Message(author: 'me', text: trimmed, timestamp: DateTime.now()),
    );
  }

  @action
  void receive(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;
    messages.add(
      Message(author: 'peer', text: trimmed, timestamp: DateTime.now()),
    );
  }
}

