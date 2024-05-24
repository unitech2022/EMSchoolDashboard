// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'body_for_add_schdeul.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BodyAddSchedul _$BodyAddSchedulFromJson(Map<String, dynamic> json) =>
    BodyAddSchedul(
      ScheduleModel.fromJson(json['schedule'] as Map<String, dynamic>),
      (json['sessions'] as List<dynamic>)
          .map((e) => SessionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BodyAddSchedulToJson(BodyAddSchedul instance) =>
    <String, dynamic>{
      'schedule': instance.schedule,
      'sessions': instance.sessions,
    };
