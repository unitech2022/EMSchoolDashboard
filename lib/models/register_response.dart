
//dart run build_runner build
import 'package:json_annotation/json_annotation.dart';

part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponse {
 
  final String message;
   final bool status;

  RegisterResponse(this.message, this.status);

    factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);
}
