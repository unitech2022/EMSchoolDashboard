import 'package:emschool_dashboard/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';
//dart run build_runner build
part 'home_response.g.dart';

@JsonSerializable()
class HomeResponse {
  final int subjects, lessons, students, teachers;
  final List<UserResponse> recentUsers;

  HomeResponse(this.subjects, this.lessons, this.students, this.teachers, this.recentUsers);

  factory HomeResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseFromJson(json);
}
