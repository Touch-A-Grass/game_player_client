part of 'chat_bloc.dart';

@freezed
class ChatState with _$ChatState {
  const factory ChatState({
    @Default([]) List<MessageUiModel> messages,
  }) = _ChatState;
}
