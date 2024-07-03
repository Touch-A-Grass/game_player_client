import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_player_client/data/models/character.dart';
import 'package:game_player_client/data/models/user.dart';

part 'lobby.freezed.dart';

part 'lobby.g.dart';

@freezed
class Lobby with _$Lobby {
  factory Lobby({
    required String id,
    required String name,
    required String code,
    required int maxPlayers,
    required int playersCount,
    required String owner,
    required List<User> users,
    required List<Character> characters,
  }) = _Lobby;

  factory Lobby.fromJson(Map<String, dynamic> json) => _$LobbyFromJson(json);
}
