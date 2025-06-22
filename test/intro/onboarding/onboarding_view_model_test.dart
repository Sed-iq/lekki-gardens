import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:LekkiGardens/features/intro/onboarding/onboarding_view_model.dart';
import 'package:LekkiGardens/utils/data_utils.dart';

void main() {
  group('OnboardingViewModel Tests', () {
    late OnboardingViewModel viewModel;

    setUp(() {
      Get.testMode = true;
      viewModel = OnboardingViewModel();
      viewModel.initializeControllers();
    });

    tearDown(() {
      viewModel.disposeControllers();
    });

    test('should initialize with first onboarding page', () {
      expect(viewModel.currentOnboardingListener.value, 0);
    });

    test('should initialize page controllers', () {
      expect(viewModel.pageController, isNotNull);
      expect(viewModel.backgroundController, isNotNull);
    });

    test('should update current page on background page change', () {
      viewModel.onBackgroundPageChanged(1);
      expect(viewModel.currentOnboardingListener.value, 1);
    });

    test('should update current page on content page change', () {
      viewModel.onContentPageChanged(2);
      expect(viewModel.currentOnboardingListener.value, 2);
    });

    test('should prevent simultaneous scrolling', () {
      viewModel.isBackgroundScrolling = true;
      viewModel.onContentPageChanged(1);
      expect(viewModel.isContentScrolling, false);
    });
  });
}