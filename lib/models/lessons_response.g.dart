// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lessons_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonsResponse _$LessonsResponseFromJson(Map<String, dynamic> json) =>
    LessonsResponse(
      currentPage: json['currentPage'] as int,
      totalPages: json['totalPages'] as int,
      items: (json['items'] as List<dynamic>)
          .map((e) => LessonModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LessonsResponseToJson(LessonsResponse instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'totalPages': instance.totalPages,
      'items': instance.items,
    };

LessonsAdminResponse _$LessonsAdminResponseFromJson(
        Map<String, dynamic> json) =>
    LessonsAdminResponse(
      CourseModel.fromJson(json['course'] as Map<String, dynamic>),
      (json['units'] as List<dynamic>)
          .map((e) => UnitResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LessonsAdminResponseToJson(
        LessonsAdminResponse instance) =>
    <String, dynamic>{
      'course': instance.course,
      'units': instance.units,
    };
