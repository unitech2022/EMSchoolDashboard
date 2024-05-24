import 'package:json_annotation/json_annotation.dart';

import 'base_response.dart';
//dart run build_runner build
part 'news_model.g.dart';

@JsonSerializable()
class NewsModel {
  final int id;
  final String nameAr;
  final String nameEng;
  final String descAr;
  final String descEng;
  final String image;
  final int status;
  final String createdAt;

  NewsModel(
      {required this.id,
      required this.nameAr,
      required this.nameEng,
      required this.descAr,
      required this.descEng,
      required this.image,
      required this.status,
      required this.createdAt});

  factory NewsModel.fromJson(Map<String, dynamic> json) =>
      _$NewsModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsModelToJson(this);
}

//dart run build_runner build
@JsonSerializable()
class NewsResponse extends BaseResponse {
  final List<NewsModel> items;
  NewsResponse({
    required super.currentPage,
    required super.totalPages,
    required this.items,
  });

  factory NewsResponse.fromJson(Map<String, dynamic> json) =>
      _$NewsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NewsResponseToJson(this);
}
