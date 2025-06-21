import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'env/env.dart';
part 'api_client.g.dart';

@RestApi(baseUrl: Env.MVVMTEMPLATE_REMOTE_BASEURL)
abstract class ApiClient {

  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST("/auth/login")
  @FormUrlEncoded()
  Stream<String> signInUser(@Field() String email, @Field() String password, @Field() String deviceToken, @Field() String pushToken);



}