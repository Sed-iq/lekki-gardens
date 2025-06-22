import 'package:LekkiGardens/features/auth/account_recovery/account_recovery.dart';
import 'package:LekkiGardens/features/auth/signup/sign_up.dart';
import 'package:get/get.dart';
import 'package:LekkiGardens/features/auth/signin/sign_in.dart';
import 'package:LekkiGardens/utils/route_constants.dart';

import 'features/intro/onboarding/onboarding.dart';

class Routes {
  static Duration duration = Duration(milliseconds: 400);
  static Transition transition = Transition.rightToLeft;
  static final List<GetPage> pageRouteDataList = [
    GetPage(name: RouteConstants.ONBOARDING, transition: transition, transitionDuration: duration, page: () => Onboarding()),
    GetPage(name: RouteConstants.SIGNIN, transition: transition, transitionDuration: duration, page: () => SignIn()),
    GetPage(name: RouteConstants.SIGNUP, transition: transition, transitionDuration: duration, page: () => SignUp()),
    GetPage(name: RouteConstants.ACCOUNT_RECOVERY, transition: transition, transitionDuration: duration, page: () => AccountRecovery()),
  ];
}
