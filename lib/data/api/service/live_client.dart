import 'dart:async';
import 'dart:convert';

import 'package:game_player_client/data/models/attribute.dart';
import 'package:game_player_client/data/models/character.dart';
import 'package:game_player_client/data/models/lobby.dart';
import 'package:game_player_client/data/models/message.dart';
import 'package:game_player_client/data/models/roll.dart';
import 'package:game_player_client/data/models/skill.dart';
import 'package:game_player_client/data/models/user.dart';
import 'package:game_player_client/data/storage/token_storage.dart';
import 'package:game_player_client/data/storage/user_storage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class LiveClient {
  final TokenStorage _tokenStorage;
  final UserStorage _userStorage;

  LiveClient(this._tokenStorage, this._userStorage) {
    Timer(const Duration(seconds: 5), () {});
  }

  WebSocketChannel? channel;

  final _message = PublishSubject<Message>();

  Stream<Message> get message => _message.stream;

  final _lobby = PublishSubject<Lobby>();

  Stream<Lobby> get lobby => _lobby.stream;

  final _roll = PublishSubject<Roll>();

  Stream<Roll> get roll => _roll.stream;

  Future<void> connect(String code) async {
    try {
      channel = WebSocketChannel.connect(Uri.parse('wss://147.45.158.230:8080/$code'));
      channel?.sink.add(jsonEncode({'type': 'auth', 'token': _tokenStorage.token}));
      channel?.stream.listen((event) {
        final json = jsonDecode(event.toString());
        switch (json['type']) {
          case 'message':
            _message.add(Message.fromJson(json));
            break;
          case 'lobby':
            _lobby.add(Lobby.fromJson(json));
            break;
          case 'roll':
            _roll.add(Roll.fromJson(json));
            break;
        }
      });
    } catch (_) {}

    await Future.delayed(const Duration(seconds: 2));

    final lobby = Lobby(
      id: const Uuid().v4(),
      name: 'The Witcher 3: Wild Hunt',
      code: code,
      maxPlayers: 4,
      playersCount: 1,
      owner: const Uuid().v4(),
      users: [_userStorage.get()!, const User(username: 'Fedmog1lnkv')],
      characters: [
        Character(
          id: const Uuid().v4(),
          name: 'Witcher',
          description: 'An old witcher from the witcher 3, with some new skills and attributes!',
          user: _userStorage.get()!.username,
          skills: const [
            Skill(
              name: 'Witchery',
              value: 5,
              attribute: 'Intelligence',
            ),
            Skill(
              name: 'Crafting',
              value: 5,
              attribute: 'Intelligence',
            ),
            Skill(
              name: 'Magic',
              value: 5,
              attribute: 'Intelligence',
            ),
            Skill(
              name: 'Stealth',
              value: 5,
              attribute: 'Dexterity',
            ),
          ],
          attributes: const [
            Attribute(
              name: 'Gender',
              value: 'Male',
              type: AttributeType.string,
            ),
            Attribute(
              name: 'Strength',
              value: '5',
              type: AttributeType.int,
            ),
            Attribute(
              name: 'Dexterity',
              value: '5',
              type: AttributeType.int,
            ),
            Attribute(
              name: 'Intelligence',
              value: '5',
              type: AttributeType.int,
            ),
          ],
        )
      ],
    );

    _lobby.add(lobby);

    Timer(const Duration(seconds: 10), () {
      _roll.add(const Roll(dices: [6, 20, 20]));
    });

    Timer(const Duration(seconds: 2), () {
      _message.add(const Message(text: 'hello', user: 'Fedmog1lnkv'));
    });
  }

  void send(String message) {
    channel?.sink.add(message);
  }

  void close() {
    channel?.sink.close();
  }
}
