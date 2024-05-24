import 'package:emschool_dashboard/models/base_response.dart';
import 'package:emschool_dashboard/models/subject_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'subjects_response.g.dart';

//dart run build_runner build
@JsonSerializable()
class SubjectsResponse extends BaseResponse {
  final List<SubjectModel> items;
  SubjectsResponse({
    required super.currentPage,
    required super.totalPages,
    required this.items,
  });

  factory SubjectsResponse.fromJson(Map<String, dynamic> json) =>
      _$SubjectsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SubjectsResponseToJson(this);
}
