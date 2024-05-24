
//dart run build_runner build


import 'package:json_annotation/json_annotation.dart';

part 'session_model.g.dart';
@JsonSerializable()
class SessionModel {
  final int id;
  final int scheduleId;
  final String dayAr;
  final String dayEng;
  final String subjectsAr;
  final String subjectsEng;
  final int status;
  final String createdAt;

  factory SessionModel.fromJson(Map<String, dynamic> json) =>
      _$SessionModelFromJson(json);

 Map<String, dynamic> toJson() => _$SessionModelToJson(this);
  SessionModel(
      {required this.id,
      required this.scheduleId,
      required this.dayAr,
      required this.dayEng,
      required this.subjectsAr,
      required this.subjectsEng,
      required this.status,
      required this.createdAt});
}

@JsonSerializable()
class SessionAddSchedul {
  final int id;
  final String dayAr;
  final String dayEng;
  final String subjectsAr;
  final String subjectsEng;


  factory SessionAddSchedul.fromJson(Map<String, dynamic> json) =>
      _$SessionAddSchedulFromJson(json);

 Map<String, dynamic> toJson() => _$SessionAddSchedulToJson(this);
  SessionAddSchedul(
      {
      required this.dayAr,   required this.id,
      required this.dayEng,
      required this.subjectsAr,
      required this.subjectsEng,
    });
}
