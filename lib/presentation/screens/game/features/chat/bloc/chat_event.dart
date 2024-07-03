part of 'chat_bloc.dart';

@freezed
class ChatEvent with _$ChatEvent {
  const factory ChatEvent.messageSent(String message) = _MessageSent;

  const factory ChatEvent.messagesChanged(List<MessageUiModel> messages) = _MessagesChanged;
}
