import 'package:emschool_dashboard/models/base_response.dart';
import 'package:emschool_dashboard/models/class_room_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'class_rooms_response.g.dart';

//dart run build_runner build
@JsonSerializable()
class ClassRoomsResponse extends BaseResponse {
  final List<ClassRoomModel> items;
  ClassRoomsResponse({
    required super.currentPage,
    required super.totalPages,
    required this.items,
  });

  factory ClassRoomsResponse.fromJson(Map<String, dynamic> json) =>
      _$ClassRoomsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ClassRoomsResponseToJson(this);
}
