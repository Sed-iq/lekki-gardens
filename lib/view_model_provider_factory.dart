import 'package:LekkiGardens/features/auth/account_recovery/account_recovery_view_model.dart';
import 'package:LekkiGardens/features/auth/signin/sign_in_view_model.dart';
import 'package:LekkiGardens/features/auth/signup/sign_up_view_model.dart';
import 'package:LekkiGardens/features/intro/onboarding/onboarding_view_model.dart';
import 'package:get/get.dart';

import 'base/base_view_model.dart';

class ViewModelProviderFactory implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BaseViewModel>(() => BaseViewModel(), fenix: true);
    Get.lazyPut<SignInViewModel>(() => SignInViewModel(), fenix: true);
    Get.lazyPut<OnboardingViewModel>(() => OnboardingViewModel(), fenix: true);
    Get.lazyPut<SignUpViewModel>(() => SignUpViewModel(), fenix: true);
    Get.lazyPut<AccountRecoveryViewModel>(() => AccountRecoveryViewModel(), fenix: true);
  }
}