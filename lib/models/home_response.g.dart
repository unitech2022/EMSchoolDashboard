// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeResponse _$HomeResponseFromJson(Map<String, dynamic> json) => HomeResponse(
      json['subjects'] as int,
      json['lessons'] as int,
      json['students'] as int,
      json['teachers'] as int,
      (json['recentUsers'] as List<dynamic>)
          .map((e) => UserResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomeResponseToJson(HomeResponse instance) =>
    <String, dynamic>{
      'subjects': instance.subjects,
      'lessons': instance.lessons,
      'students': instance.students,
      'teachers': instance.teachers,
      'recentUsers': instance.recentUsers,
    };
