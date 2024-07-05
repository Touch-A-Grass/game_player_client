import 'dart:convert';

import 'package:game_player_client/data/api/service/live_client.dart';
import 'package:game_player_client/data/models/character.dart';
import 'package:game_player_client/data/models/lobby.dart';
import 'package:game_player_client/data/models/message.dart';
import 'package:game_player_client/data/models/roll.dart';
import 'package:game_player_client/data/models/user.dart';
import 'package:game_player_client/data/storage/user_storage.dart';
import 'package:rxdart/rxdart.dart';

class LobbyRepository {
  final UserStorage _userStorage;
  final LiveClient _liveClient;

  LobbyRepository(this._userStorage, this._liveClient) {
    _liveClient.lobby.listen((lobby) {
      _lobby.add(lobby);
    });

    _liveClient.roll.listen((roll) {
      _roll.add(roll);
    });

    _liveClient.message.listen((message) {
      _messages.add([..._messages.value, message]);
    });
  }

  final BehaviorSubject<Lobby?> _lobby = BehaviorSubject<Lobby?>.seeded(null);
  final BehaviorSubject<List<Message>> _messages = BehaviorSubject<List<Message>>.seeded([]);
  final PublishSubject<Roll> _roll = PublishSubject<Roll>();

  Stream<Lobby?> watchLobby() => _lobby.stream;

  Stream<List<User>> watchUsers() => _lobby.stream.map((lobby) => lobby?.users ?? []);

  Stream<List<Message>> watchMessages() => _messages.stream;

  Stream<Roll> watchRoll() => _roll.stream;

  Stream<Character?> watchMyCharacter() => _lobby.stream
      .map((lobby) => lobby?.characters.firstWhere((character) => character.user == _userStorage.get()!.username));

  Future<void> join(String code) async {
    await _liveClient.connect(code);
  }

  Future<void> sendMessage(String message) async {
    _liveClient.send(
      jsonEncode(
        {
          'type': 'message',
          'message': message,
        },
      ),
    );
    final newMessage = Message(
      text: message,
      user: _userStorage.get()!.username,
    );
    _messages.add([newMessage, ..._messages.value]);
  }

  Future<void> completeRoll(RollResult result) async {}

  Future<void> leave() async {
    _lobby.add(null);
    _messages.add([]);
    try {
      _liveClient.close();
    } catch (_) {}
  }
}
