// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionModel _$SessionModelFromJson(Map<String, dynamic> json) => SessionModel(
      id: json['id'] as int,
      scheduleId: json['scheduleId'] as int,
      dayAr: json['dayAr'] as String,
      dayEng: json['dayEng'] as String,
      subjectsAr: json['subjectsAr'] as String,
      subjectsEng: json['subjectsEng'] as String,
      status: json['status'] as int,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$SessionModelToJson(SessionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'scheduleId': instance.scheduleId,
      'dayAr': instance.dayAr,
      'dayEng': instance.dayEng,
      'subjectsAr': instance.subjectsAr,
      'subjectsEng': instance.subjectsEng,
      'status': instance.status,
      'createdAt': instance.createdAt,
    };

SessionAddSchedul _$SessionAddSchedulFromJson(Map<String, dynamic> json) =>
    SessionAddSchedul(
      dayAr: json['dayAr'] as String,
      id: json['id'] as int,
      dayEng: json['dayEng'] as String,
      subjectsAr: json['subjectsAr'] as String,
      subjectsEng: json['subjectsEng'] as String,
    );

Map<String, dynamic> _$SessionAddSchedulToJson(SessionAddSchedul instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dayAr': instance.dayAr,
      'dayEng': instance.dayEng,
      'subjectsAr': instance.subjectsAr,
      'subjectsEng': instance.subjectsEng,
    };
