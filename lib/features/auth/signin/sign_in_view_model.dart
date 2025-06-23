import 'package:get/state_manager.dart';

import '../../../base/base_view_model.dart';
import '../../../utils/route_constants.dart';

class SignInViewModel extends BaseViewModel {
  RxBool rememberListener = false.obs;

  String getInitialRoute() {
    // bool hasUserLogin = getDataManager().getSaveLoginState();
    return RouteConstants.ONBOARDING;
  }

  bool isDarkMode() {
    return getDataManager().getDarkModeState();
  }
}
