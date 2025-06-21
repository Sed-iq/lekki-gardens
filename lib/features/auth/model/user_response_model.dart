import "package:json_annotation/json_annotation.dart";

import "../../../common/model/api_response_model.dart";
part "user_response_model.g.dart";

@JsonSerializable()
class UserResponseModel extends ApiResponseModel {
  @JsonKey(name: "data")
  UserDataModel userDataModel;

  UserResponseModel({required this.userDataModel}) : super(success: false, message: '');

  factory UserResponseModel.fromJson(Map<String, dynamic> json) => _$UserResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserResponseModelToJson(this);
}

@JsonSerializable()
class UserDataModel {
  @JsonKey(name: "user_id")
  String userId;
  @JsonKey(name: "first_name")
  String firstName;
  @JsonKey(name: "last_name")
  String lastName;
  @JsonKey(name: "phone_number")
  String phoneNumber;

  UserDataModel({required this.userId, required this.firstName, required this.lastName, required this.phoneNumber});

  factory UserDataModel.fromJson(Map<String, dynamic> json) => _$UserDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserDataModelToJson(this);
}
