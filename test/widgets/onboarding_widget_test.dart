import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:LekkiGardens/features/intro/onboarding/onboarding.dart';
import 'package:LekkiGardens/features/intro/onboarding/onboarding_view_model.dart';

void main() {
  group('Onboarding Widget Tests', () {
    testWidgets('should display page indicator', (WidgetTester tester) async {
      Get.testMode = true;
      Get.put(OnboardingViewModel());

      await tester.pumpWidget(
        GetMaterialApp(
          home: Onboarding(),
        ),
      );

      expect(find.byType(PageView), findsNWidgets(2)); // Background and content PageViews
      expect(find.text('Next'), findsOneWidget);
    });

    testWidgets('should display sign in link', (WidgetTester tester) async {
      Get.testMode = true;
      Get.put(OnboardingViewModel());

      await tester.pumpWidget(
        GetMaterialApp(
          home: Onboarding(),
        ),
      );

      expect(find.textContaining('Already have an account?'), findsOneWidget);
      expect(find.textContaining('Sign in'), findsOneWidget);
    });

    testWidgets('should display skip button when not on last page', (WidgetTester tester) async {
      Get.testMode = true;
      final viewModel = Get.put(OnboardingViewModel());
      viewModel.currentOnboardingListener.value = 0;

      await tester.pumpWidget(
        GetMaterialApp(
          home: Onboarding(),
        ),
      );

      expect(find.text('Skip'), findsOneWidget);
    });
  });
}