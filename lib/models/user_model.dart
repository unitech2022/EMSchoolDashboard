import 'package:json_annotation/json_annotation.dart';

//dart run build_runner build
part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String id;
  final String userName;
  final String role;
  final String fullName;

  // final String? profileImage;

  UserModel({
    required this.id,
    required this.userName,
    required this.role,
    required this.fullName,

    // required this.profileImage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class UserResponse {
  final String id;
  final String? userName;
  final String? role;
  final String? fullName;

  final String? uniqCode;

  final String? profileImage;
  final int? typeEducationId; //**  نوع التعليم

  final int? stageId; //;المرحلة التعليمي
  final int? classRoomId; //;صف

  final int? subjectId;
  final String? password;
  final String? createdAt;


  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  UserResponse(this.password,this.id, this.userName, this.role, this.fullName, this.uniqCode, this.profileImage, this.typeEducationId, this.stageId, this.classRoomId, this.subjectId, this.createdAt);
}
