import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:LekkiGardens/data/sharedPreference/shared_preference_helper.dart';
import '../../features/auth/model/user_response_model.dart';
import '../../utils/app_constants.dart';

class AppSharedPreferenceHelper implements SharedPreferenceHelper {

  final GetStorage getStorage;

  AppSharedPreferenceHelper(this.getStorage);

  @override
  bool getOnBoardingState() {
    return getStorage.read(AppConstants.ONBOARDING_STATE) ?? false;
  }

  @override
  void saveOnBoardingState(bool hasOnBoarded) {
    getStorage.write(AppConstants.ONBOARDING_STATE, hasOnBoarded);
  }

  @override
  bool getSaveLoginState() {
    return getStorage.read(AppConstants.LOGIN_STATE) ?? false;
  }

  @override
  void saveLoginState(bool hasLogin) {
    getStorage.write(AppConstants.LOGIN_STATE, hasLogin);
  }

  @override
  String getSaveLoginToken() {
    return getStorage.read(AppConstants.LOGIN_TOKEN) ?? "";
  }

  @override
  void saveLoginToken(String token) {
    getStorage.write(AppConstants.LOGIN_TOKEN, token);
  }

  @override
  UserDataModel? getLoginUser() {
    return (getStorage.read(AppConstants.LOGIN_USER) != null)
        ? UserDataModel.fromJson(
        jsonDecode(getStorage.read(AppConstants.LOGIN_USER)!))
        : null;
  }

  @override
  void saveLoginUser(UserDataModel userDataModel) {
    getStorage.write(AppConstants.LOGIN_USER, jsonEncode(userDataModel));
  }

  @override
  bool getDarkModeState() {
    return getStorage.read(AppConstants.DARKMODE_STATE) ?? false;
  }

  @override
  void saveDarkModeState(bool hasDarkMode) {
    getStorage.write(AppConstants.DARKMODE_STATE, hasDarkMode);
  }

}