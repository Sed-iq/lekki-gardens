import 'package:dio/dio.dart';
import '../../common/model/api_response_model.dart';
import 'api_client.dart';
import 'api_helper.dart';
import 'env/env.dart';

class AppApiHelper implements ApiHelper {
  final Dio dio;

  AppApiHelper(this.dio);

  ApiClient getKichorApiClient() {
    return ApiClient(dio, baseUrl: Env.MVVMTEMPLATE_REMOTE_BASEURL);
  }

  @override
  Stream<String> signInUser(String email, String password, String deviceToken, String pushToken) {
    return getKichorApiClient().signInUser(email, password, deviceToken, pushToken);
  }

}