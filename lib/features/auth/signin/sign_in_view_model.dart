import '../../../base/base_view_model.dart';
import '../../../utils/route_constants.dart';

class SignInViewModel extends BaseViewModel {
  String getInitialRoute() {
    bool hasUserLogin = getDataManager().getSaveLoginState(); // get login state
    setUserLogin(hasUserLogin);
    return RouteConstants.DASHBOARD; // returns dashboard but based on login state
  }

  bool isDarkMode() {
    return getDataManager().getDarkModeState();
  }
}
