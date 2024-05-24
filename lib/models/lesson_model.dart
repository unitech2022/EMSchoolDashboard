
import 'package:json_annotation/json_annotation.dart';

//dart run build_runner build
part 'lesson_model.g.dart';
@JsonSerializable()
class LessonModel {
final int id;
final int unitId;
final String nameAr;
final String nameEng;
final String descAr;
final String descEng;
final String linkVidio;
final String image;
final bool isComplated;
final int status;
final int views;
final int liks;
final double rate;
final int subjectId;
final String createdAt;

  LessonModel({required this.id,
    required this.unitId,
    required this.nameAr,
    required this.nameEng,
    required this.descAr,
    required this.descEng,
    required this.linkVidio,
    required this.subjectId,
    required this.image,
    required this.views,
    required this.isComplated,
    required this.status,
      required this.liks,
           required this.rate,
    required this.createdAt});

factory LessonModel.fromJson(Map<String, dynamic> json) =>
    _$LessonModelFromJson(json);



Map<String, dynamic> toJson() => _$LessonModelToJson(this);
}


