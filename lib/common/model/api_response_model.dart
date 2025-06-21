import 'package:json_annotation/json_annotation.dart';
part 'api_response_model.g.dart';

@JsonSerializable()
class ApiResponseModel{
  bool success;
  String message;

  ApiResponseModel({required this.success, required this.message});

  factory ApiResponseModel.fromJson(Map<String, dynamic> json) => _$ApiResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$ApiResponseModelToJson(this);

}