import 'package:LekkiGardens/data/api/api_helper.dart';
import 'package:LekkiGardens/data/api/app_api_helper.dart';
import 'package:LekkiGardens/data/app_data_manager.dart';
import 'package:LekkiGardens/data/data_manager.dart';
import 'package:LekkiGardens/data/database/app_database_helper.dart';
import 'package:LekkiGardens/data/database/database_helper.dart';
import 'package:LekkiGardens/data/sharedPreference/app_shared_preference_helper.dart';
import 'package:LekkiGardens/data/sharedPreference/shared_preference_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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
    GetStorage getStorage = GetStorage();
    Get.put(getStorage);
    var dio = Dio(BaseOptions(sendTimeout: Duration(minutes: 5), connectTimeout: Duration(minutes: 5), receiveTimeout: Duration(minutes: 5)));

    Get.put(AppApiHelper(dio) as ApiHelper);
    Get.put(AppSharedPreferenceHelper(Get.find()) as SharedPreferenceHelper);
    Get.put(AppDatabaseHelper(Get.find()) as DatabaseHelper);
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
