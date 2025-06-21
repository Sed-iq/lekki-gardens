import 'package:LekkiGardens/features/auth/signin/sign_in_view_model.dart';
import 'package:get/get.dart';

import 'base/base_view_model.dart';

class ViewModelProviderFactory implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BaseViewModel>(() => BaseViewModel(), fenix: true);
    Get.lazyPut<SignInViewModel>(() => SignInViewModel(), fenix: true);
  }
}