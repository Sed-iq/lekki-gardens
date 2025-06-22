import 'package:LekkiGardens/base/base_view_model.dart';
import 'package:LekkiGardens/features/auth/signin/sign_in_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:LekkiGardens/features/auth/signup/sign_up.dart';
import 'package:LekkiGardens/features/auth/signup/sign_up_view_model.dart';

void main() {
  group('SignUp Widget Tests', () {
    testWidgets('should display create account text', (WidgetTester tester) async {
      Get.testMode = true;
      Get.put(SignInViewModel());

      await tester.pumpWidget(GetMaterialApp(home: SignUp()));

      expect(find.text('Create Account'), findsOneWidget);
      // expect(find.text('Enter your information and let\'s get started'), findsOneWidget);
    });

    testWidgets('should display form fields', (WidgetTester tester) async {
      Get.testMode = true;
      Get.put(SignUpViewModel());

      await tester.pumpWidget(GetMaterialApp(home: SignUp()));

      expect(find.text('First Name'), findsOneWidget);
      expect(find.text('Last Name'), findsOneWidget);
      expect(find.text('Email Address'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Confirm Password'), findsOneWidget);
    });

    testWidgets('should display terms and conditions checkbox', (WidgetTester tester) async {
      Get.testMode = true;

      try {
        // Initialize dependencies
        Get.lazyPut<SignUpViewModel>(() => SignUpViewModel());

        await tester.pumpWidget(GetMaterialApp(home: SignUp()));

        // Verify the text
        expect(find.text('By creating an account'), findsOneWidget);

        // Verify the checkbox
        expect(find.byType(Checkbox), findsOneWidget);
      } catch (e, stackTrace) {
        print('Caught exception: $e');
        print('Stack trace: $stackTrace');
        rethrow;
      } finally {
        Get.testMode = false;
      }
    });
  });
}
