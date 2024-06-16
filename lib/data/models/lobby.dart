import 'package:freezed_annotation/freezed_annotation.dart';

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
  }) = _Lobby;

  factory Lobby.fromJson(Map<String, dynamic> json) => _$LobbyFromJson(json);
}
