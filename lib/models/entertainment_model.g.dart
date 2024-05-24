// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entertainment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EntertainmentModel _$EntertainmentModelFromJson(Map<String, dynamic> json) =>
    EntertainmentModel(
      id: json['id'] as int,
      image: json['image'] as String,
      link: json['link'] as String,
      status: json['status'] as int,
      createAte: json['createAte'] as String,
      nameAr: json['nameAr'] as String,
      nameEng: json['nameEng'] as String,
    );

Map<String, dynamic> _$EntertainmentModelToJson(EntertainmentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'link': instance.link,
      'nameAr': instance.nameAr,
      'nameEng': instance.nameEng,
      'status': instance.status,
      'createAte': instance.createAte,
    };

EnntertainmentssResponse _$EnntertainmentssResponseFromJson(
        Map<String, dynamic> json) =>
    EnntertainmentssResponse(
      currentPage: json['currentPage'] as int,
      totalPages: json['totalPages'] as int,
      items: (json['items'] as List<dynamic>)
          .map((e) => EntertainmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EnntertainmentssResponseToJson(
        EnntertainmentssResponse instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'totalPages': instance.totalPages,
      'items': instance.items,
    };
