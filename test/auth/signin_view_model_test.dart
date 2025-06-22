import 'package:LekkiGardens/data/app_data_manager.dart';
import 'package:LekkiGardens/data/data_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:LekkiGardens/features/auth/signin/sign_in_view_model.dart';
import 'package:LekkiGardens/utils/route_constants.dart';

class MockDataManager extends Mock {
  bool getSaveLoginState() => false;
  bool getDarkModeState() => false;
}

void main() {
  group('SignInViewModel Tests', () {
    late SignInViewModel viewModel;
    Get.put(AppDataManager(Get.find(), Get.find(), Get.find()) as DataManager);
    setUp(() {
      viewModel = SignInViewModel();
    });

    test('should initialize with remember me as false', () {
      expect(viewModel.rememberListener.value, false);
    });

    test('should toggle remember me state', () {
      viewModel.rememberListener.value = true;
      expect(viewModel.rememberListener.value, true);
    });

    test('should return onboarding as initial route', () {
      expect(viewModel.getInitialRoute(), RouteConstants.ONBOARDING);
    });
  });
}