import 'package:emschool_dashboard/models/base_response.dart';
import 'package:emschool_dashboard/models/course_model.dart';
import 'package:emschool_dashboard/models/lesson_model.dart';
import 'package:emschool_dashboard/models/unit_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'lessons_response.g.dart';

//dart run build_runner build
@JsonSerializable()
class LessonsResponse extends BaseResponse {
  final List<LessonModel> items;
  LessonsResponse({
    required super.currentPage,
    required super.totalPages,
    required this.items,
  });

  factory LessonsResponse.fromJson(Map<String, dynamic> json) =>
      _$LessonsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LessonsResponseToJson(this);
}

@JsonSerializable()
class LessonsAdminResponse {
  final CourseModel course;
  final List<UnitResponse> units;


  factory LessonsAdminResponse.fromJson(Map<String, dynamic> json) =>
      _$LessonsAdminResponseFromJson(json);

  LessonsAdminResponse(this.course, this.units);

  Map<String, dynamic> toJson() => _$LessonsAdminResponseToJson(this);
}
