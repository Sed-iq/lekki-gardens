import '../../common/model/api_response_model.dart';

abstract class ApiHelper {

  Stream<String> signInUser(String email, String password, String deviceToken, String pushToken);


}