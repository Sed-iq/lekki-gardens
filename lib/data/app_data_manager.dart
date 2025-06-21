import 'package:LekkiGardens/data/sharedPreference/shared_preference_helper.dart';

import '../common/model/api_response_model.dart';
import '../features/auth/model/user_response_model.dart';
import 'api/api_helper.dart';
import 'data_manager.dart';
import 'database/database_helper.dart';

class AppDataManager implements DataManager {
  final ApiHelper apiHelper;
  final SharedPreferenceHelper sharedPreferenceHelper;
  final DatabaseHelper databaseHelper;

  AppDataManager(this.apiHelper, this.sharedPreferenceHelper, this.databaseHelper);

  @override
  bool getOnBoardingState() {
    return sharedPreferenceHelper.getOnBoardingState();
  }

  @override
  void saveOnBoardingState(bool hasOnBoarded) async {
    sharedPreferenceHelper.saveOnBoardingState(hasOnBoarded);
  }

  @override
  bool getSaveLoginState() {
    return sharedPreferenceHelper.getSaveLoginState();
  }

  @override
  void saveLoginState(bool hasLogin) {
    return sharedPreferenceHelper.saveLoginState(hasLogin);
  }

  @override
  String getSaveLoginToken() {
    return sharedPreferenceHelper.getSaveLoginToken();
  }

  @override
  void saveLoginToken(String token) {
    return sharedPreferenceHelper.saveLoginToken(token);
  }

  @override
  UserDataModel? getLoginUser() {
    return sharedPreferenceHelper.getLoginUser();
  }

  @override
  void saveLoginUser(UserDataModel userDataModel) {
    return sharedPreferenceHelper.saveLoginUser(userDataModel);
  }

  @override
  bool getDarkModeState() {
    return sharedPreferenceHelper.getDarkModeState();
  }

  @override
  void saveDarkModeState(bool hasDarkMode) {
    return sharedPreferenceHelper.saveDarkModeState(hasDarkMode);
  }

  @override
  Future<void> saveApiNetworkCache(String key, String? value) {
    return databaseHelper.saveApiNetworkCache(key, value);
  }

  @override
  Stream<String?> getApiNetworkCache(String key) {
    return databaseHelper.getApiNetworkCache(key);
  }

  @override
  Future<void> deleteApiNetworkCache(String key) {
    return databaseHelper.deleteApiNetworkCache(key);
  }

  @override
  Stream<bool> isApiNetworkCacheExists(String key) {
    return databaseHelper.isApiNetworkCacheExists(key);
  }

  @override
  Future<void> clearApiNetworkCache() {
    return databaseHelper.clearApiNetworkCache();
  }

  @override
  Stream<String> signInUser(String email, String password, String deviceToken, String pushToken) {
    return apiHelper.signInUser(email, password, deviceToken, pushToken);
  }



}