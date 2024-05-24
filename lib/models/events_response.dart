

import 'package:emschool_dashboard/models/base_response.dart';

import 'package:json_annotation/json_annotation.dart';

import 'bunner_model.dart';

part 'events_response.g.dart';

//dart run build_runner build
@JsonSerializable()
class EventsResponse extends BaseResponse {
  final List<BannerModel> items;
  EventsResponse({
    required super.currentPage,
    required super.totalPages,
    required this.items,
  });

  factory EventsResponse.fromJson(Map<String, dynamic> json) =>
      _$EventsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EventsResponseToJson(this);
}