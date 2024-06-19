import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_user_request.freezed.dart';

part 'update_user_request.g.dart';

@freezed
class UpdateUserRequest with _$UpdateUserRequest {
  const factory UpdateUserRequest({
    required String username,
  }) = _UpdateUserRequest;

  factory UpdateUserRequest.fromJson(Map<String, dynamic> json) => _$UpdateUserRequestFromJson(json);
}
