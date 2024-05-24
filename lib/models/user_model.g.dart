// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String,
      userName: json['userName'] as String,
      role: json['role'] as String,
      fullName: json['fullName'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'role': instance.role,
      'fullName': instance.fullName,
    };

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      json['password'] as String?,
      json['id'] as String,
      json['userName'] as String?,
      json['role'] as String?,
      json['fullName'] as String?,
      json['uniqCode'] as String?,
      json['profileImage'] as String?,
      json['typeEducationId'] as int?,
      json['stageId'] as int?,
      json['classRoomId'] as int?,
      json['subjectId'] as int?,
      json['createdAt'] as String?,
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'role': instance.role,
      'fullName': instance.fullName,
      'uniqCode': instance.uniqCode,
      'profileImage': instance.profileImage,
      'typeEducationId': instance.typeEducationId,
      'stageId': instance.stageId,
      'classRoomId': instance.classRoomId,
      'subjectId': instance.subjectId,
      'password': instance.password,
      'createdAt': instance.createdAt,
    };
