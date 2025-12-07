part of 'chat_state.dart';

mixin _$ChatState on _ChatState, Store {
  late final _$messagesAtom = Atom(
    name: '_ChatState.messages',
    context: context,
  );

  @override
  ObservableList<Message> get messages {
    _$messagesAtom.reportRead();
    return super.messages;
  }

  @override
  set messages(ObservableList<Message> value) {
    _$messagesAtom.reportWrite(value, super.messages, () {
      super.messages = value;
    });
  }

  late final _$_ChatStateActionController = ActionController(
    name: '_ChatState',
    context: context,
  );

  @override
  void send(String text) {
    final _$actionInfo = _$_ChatStateActionController.startAction(
      name: '_ChatState.send',
    );
    try {
      return super.send(text);
    } finally {
      _$_ChatStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void receive(String text) {
    final _$actionInfo = _$_ChatStateActionController.startAction(
      name: '_ChatState.receive',
    );
    try {
      return super.receive(text);
    } finally {
      _$_ChatStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
messages: ${messages}
    ''';
  }
}
