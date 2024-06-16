part of 'lobbies_bloc.dart';

@freezed
class LobbiesEvent with _$LobbiesEvent {
  const factory LobbiesEvent.codeChanged(String code) = _CodeChanged;

  const factory LobbiesEvent.joinRequested() = _JoinRequested;
}
