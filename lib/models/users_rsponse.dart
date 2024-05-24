import 'package:emschool_dashboard/models/base_response.dart';
import 'package:emschool_dashboard/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'users_rsponse.g.dart';

//dart run build_runner build
@JsonSerializable()
class UsersResponse extends BaseResponse {
  final List<UserResponse> items;
  UsersResponse({
    required super.currentPage,
    required super.totalPages,
    required this.items,
  });

  factory UsersResponse.fromJson(Map<String, dynamic> json) =>
      _$UsersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UsersResponseToJson(this);
}
