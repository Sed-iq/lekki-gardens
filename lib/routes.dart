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
  ];
}
