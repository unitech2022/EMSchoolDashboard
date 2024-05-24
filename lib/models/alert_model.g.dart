// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alert_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlertModel _$AlertModelFromJson(Map<String, dynamic> json) => AlertModel(
      id: json['id'] as int,
      userId: json['userId'] as String,
      titleAr: json['titleAr'] as String,
      titleEng: json['titleEng'] as String,
      descriptionAr: json['descriptionAr'] as String,
      descriptionEng: json['descriptionEng'] as String,
      viewed: json['viewed'] as bool,
      pageId: json['pageId'] as int,
      type: json['type'] as int,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$AlertModelToJson(AlertModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'titleAr': instance.titleAr,
      'titleEng': instance.titleEng,
      'descriptionAr': instance.descriptionAr,
      'descriptionEng': instance.descriptionEng,
      'viewed': instance.viewed,
      'pageId': instance.pageId,
      'type': instance.type,
      'createdAt': instance.createdAt,
    };

AlertResponse _$AlertResponseFromJson(Map<String, dynamic> json) =>
    AlertResponse(
      currentPage: json['currentPage'] as int,
      totalPages: json['totalPages'] as int,
      items: (json['items'] as List<dynamic>)
          .map((e) => AlertModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AlertResponseToJson(AlertResponse instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'totalPages': instance.totalPages,
      'items': instance.items,
    };
