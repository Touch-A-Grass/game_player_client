import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_player_client/data/models/user.dart';

part 'message_ui_model.freezed.dart';

@freezed
class MessageUiModel with _$MessageUiModel {
  const factory MessageUiModel({
    required String text,
    required User user,
  }) = _MessageUiModel;
}