import 'package:emschool_dashboard/models/base_response.dart';
import 'package:emschool_dashboard/models/type_education_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'type_educations_response.g.dart';

//dart run build_runner build
@JsonSerializable()
class TypeEducationsResponse extends BaseResponse {
  final List<TypeEducationModel> items;
  TypeEducationsResponse({
    required super.currentPage,
    required super.totalPages,
    required this.items,
  });

  factory TypeEducationsResponse.fromJson(Map<String, dynamic> json) =>
      _$TypeEducationsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TypeEducationsResponseToJson(this);
}
