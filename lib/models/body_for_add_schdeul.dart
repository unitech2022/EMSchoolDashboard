import 'package:emschool_dashboard/models/schedule_model.dart';
import 'package:emschool_dashboard/models/session_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'body_for_add_schdeul.g.dart';
//dart run build_runner build
@JsonSerializable()
class BodyAddSchedul {
 final ScheduleModel schedule;

 final  List<SessionModel> sessions;

  BodyAddSchedul(this.schedule, this.sessions);

  factory BodyAddSchedul.fromJson(Map<String, dynamic> json) =>
      _$BodyAddSchedulFromJson(json);

  Map<String, dynamic> toJson() => _$BodyAddSchedulToJson(this);
}
