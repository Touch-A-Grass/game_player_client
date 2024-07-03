import 'package:game_player_client/data/models/attribute.dart';
import 'package:game_player_client/data/models/character.dart';
import 'package:game_player_client/data/models/lobby.dart';
import 'package:game_player_client/data/models/message.dart';
import 'package:game_player_client/data/models/roll.dart';
import 'package:game_player_client/data/models/skill.dart';
import 'package:game_player_client/data/models/user.dart';
import 'package:game_player_client/data/storage/user_storage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

class LobbyRepository {
  final UserStorage _userStorage;

  LobbyRepository(this._userStorage);

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
    await Future.delayed(const Duration(seconds: 2));
    final lobby = Lobby(
      id: const Uuid().v4(),
      name: 'The Witcher 3: Wild Hunt',
      code: code,
      maxPlayers: 4,
      playersCount: 1,
      owner: const Uuid().v4(),
      users: [_userStorage.get()!],
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
  }

  Future<void> sendMessage(String message) async {
    final newMessage = Message(
      text: message,
      user: _userStorage.get()!.username,
    );
    _messages.add([newMessage, ..._messages.value]);
    await Future.delayed(const Duration(seconds: 2));
    _roll.add(const Roll(dices: [10, 15]));
  }

  Future<void> completeRoll(RollResult result) async {}

  Future<void> leave() async {
    _lobby.add(null);
    _messages.add([]);
  }
}
