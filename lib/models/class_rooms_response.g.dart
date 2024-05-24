// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_rooms_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassRoomsResponse _$ClassRoomsResponseFromJson(Map<String, dynamic> json) =>
    ClassRoomsResponse(
      currentPage: json['currentPage'] as int,
      totalPages: json['totalPages'] as int,
      items: (json['items'] as List<dynamic>)
          .map((e) => ClassRoomModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ClassRoomsResponseToJson(ClassRoomsResponse instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'totalPages': instance.totalPages,
      'items': instance.items,
    };
