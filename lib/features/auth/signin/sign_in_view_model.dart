import '../../../base/base_view_model.dart';
import '../../../utils/route_constants.dart';

class SignInViewModel extends BaseViewModel {
  String getInitialRoute() {
    bool hasUserLogin = getDataManager().getSaveLoginState();

    if (hasUserLogin) {
      return RouteConstants.DASHBOARD;
    } else {
      return RouteConstants.ONBOARDING;
    }
  }

  bool isDarkMode() {
    return getDataManager().getDarkModeState();
  }
}
