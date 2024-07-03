import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_player_client/data/repository/lobby_repository.dart';
import 'package:game_player_client/presentation/screens/game/features/chat/model/message_ui_model.dart';
import 'package:game_player_client/presentation/util/bloc_util.dart';
import 'package:rxdart/rxdart.dart';

part 'chat_bloc.freezed.dart';

part 'chat_event.dart';

part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> with SubscriptionBloc {
  final LobbyRepository _lobbyRepository;

  ChatBloc(this._lobbyRepository) : super(const ChatState()) {
    on<_MessagesChanged>((event, emit) => emit(state.copyWith(messages: event.messages)));

    on<_MessageSent>((event, emit) async {
      await _lobbyRepository.sendMessage(event.message);
    });

    subscribe(
      Rx.combineLatest2(
          _lobbyRepository.watchMessages(),
          _lobbyRepository.watchUsers(),
          (messages, users) => messages
              .map((message) => MessageUiModel(
                    text: message.text,
                    user: users.firstWhere((user) => user.username == message.user),
                  ))
              .toList()),
      (messages) {
        add(ChatEvent.messagesChanged(messages));
      },
    );
  }
}
