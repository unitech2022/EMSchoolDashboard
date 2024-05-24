import 'package:emschool_dashboard/models/base_response.dart';
import 'package:emschool_dashboard/models/stage_model.dart';

import 'package:json_annotation/json_annotation.dart';

part 'stages_response.g.dart';

//dart run build_runner build
@JsonSerializable()
class StagesResponse extends BaseResponse {
  final List<StageModel> items;
  StagesResponse({
    required super.currentPage,
    required super.totalPages,
    required this.items,
  });

  factory StagesResponse.fromJson(Map<String, dynamic> json) =>
      _$StagesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StagesResponseToJson(this);
}
