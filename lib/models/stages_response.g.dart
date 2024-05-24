// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stages_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StagesResponse _$StagesResponseFromJson(Map<String, dynamic> json) =>
    StagesResponse(
      currentPage: json['currentPage'] as int,
      totalPages: json['totalPages'] as int,
      items: (json['items'] as List<dynamic>)
          .map((e) => StageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StagesResponseToJson(StagesResponse instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'totalPages': instance.totalPages,
      'items': instance.items,
    };
