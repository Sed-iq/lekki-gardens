import 'package:LekkiGardens/utils/rx_data_stream.dart';
import 'package:flutter/material.dart';
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

  void siginInUser(BuildContext context) {
    String enteredEmail = emailController.text.trim();
    String enteredPassword = passwordController.text.trim();

    // RxDataStream.sendNetworkRequest(context: context, viewModel: this, enableNetworkLoading: enableNetworkLoading, stream: stream)
  }
}
