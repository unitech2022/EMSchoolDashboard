// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_educations_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TypeEducationsResponse _$TypeEducationsResponseFromJson(
        Map<String, dynamic> json) =>
    TypeEducationsResponse(
      currentPage: json['currentPage'] as int,
      totalPages: json['totalPages'] as int,
      items: (json['items'] as List<dynamic>)
          .map((e) => TypeEducationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TypeEducationsResponseToJson(
        TypeEducationsResponse instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'totalPages': instance.totalPages,
      'items': instance.items,
    };
