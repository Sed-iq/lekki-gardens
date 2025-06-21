import '../../features/auth/model/user_response_model.dart';

abstract class SharedPreferenceHelper {

  bool getOnBoardingState();

  void saveOnBoardingState(bool hasOnBoarded);

  bool getSaveLoginState();

  void saveLoginState(bool hasLogin);

  String getSaveLoginToken();

  void saveLoginToken(String token);

  UserDataModel? getLoginUser();

  void saveLoginUser(UserDataModel userDataModel);

  bool getDarkModeState();

  void saveDarkModeState(bool hasDarkMode);
}