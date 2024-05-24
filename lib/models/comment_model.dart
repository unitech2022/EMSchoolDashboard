
import 'package:json_annotation/json_annotation.dart';

import 'user_model.dart';

//dart run build_runner build
part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel {
  final int id;
  final int lessonId;
  final String userId;
  final String text;
  final int status;
  final String createAte;

  CommentModel(
      {required this.id,
      required this.lessonId,
      required this.userId,
      required this.text,
      required this.status,
      required this.createAte});

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);
}

@JsonSerializable()
class CommentResponse{
  final UserModel userDetail;
  final CommentModel comment;

  CommentResponse({required this.userDetail, required this.comment});
  factory CommentResponse.fromJson(Map<String, dynamic> json) =>
      _$CommentResponseFromJson(json);
}
