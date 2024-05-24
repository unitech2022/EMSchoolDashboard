// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonModel _$LessonModelFromJson(Map<String, dynamic> json) => LessonModel(
      id: json['id'] as int,
      unitId: json['unitId'] as int,
      nameAr: json['nameAr'] as String,
      nameEng: json['nameEng'] as String,
      descAr: json['descAr'] as String,
      descEng: json['descEng'] as String,
      linkVidio: json['linkVidio'] as String,
      subjectId: json['subjectId'] as int,
      image: json['image'] as String,
      views: json['views'] as int,
      isComplated: json['isComplated'] as bool,
      status: json['status'] as int,
      liks: json['liks'] as int,
      rate: (json['rate'] as num).toDouble(),
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$LessonModelToJson(LessonModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'unitId': instance.unitId,
      'nameAr': instance.nameAr,
      'nameEng': instance.nameEng,
      'descAr': instance.descAr,
      'descEng': instance.descEng,
      'linkVidio': instance.linkVidio,
      'image': instance.image,
      'isComplated': instance.isComplated,
      'status': instance.status,
      'views': instance.views,
      'liks': instance.liks,
      'rate': instance.rate,
      'subjectId': instance.subjectId,
      'createdAt': instance.createdAt,
    };
