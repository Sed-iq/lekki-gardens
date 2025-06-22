import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:LekkiGardens/features/auth/signin/sign_in.dart';
import 'package:LekkiGardens/features/auth/signin/sign_in_view_model.dart';

void main() {
  group('SignIn Widget Tests', () {
    testWidgets('should display welcome text', (WidgetTester tester) async {
      Get.testMode = true;
      Get.put(SignInViewModel());

      await tester.pumpWidget(
        GetMaterialApp(
          home: SignIn(),
        ),
      );

      expect(find.text('Welcome Back!'), findsOneWidget);
      expect(find.text('Login to access your personalized real estate experience'), findsOneWidget);
    });

    testWidgets('should display username and password fields', (WidgetTester tester) async {
      Get.testMode = true;
      Get.put(SignInViewModel());

      await tester.pumpWidget(
        GetMaterialApp(
          home: SignIn(),
        ),
      );

      expect(find.text('Username'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
    });

    testWidgets('should display remember me checkbox', (WidgetTester tester) async {
      Get.testMode = true;
      Get.put(SignInViewModel());

      await tester.pumpWidget(
        GetMaterialApp(
          home: SignIn(),
        ),
      );

      expect(find.text('Remember me'), findsOneWidget);
      expect(find.byType(Checkbox), findsOneWidget);
    });

    testWidgets('should display social login options', (WidgetTester tester) async {
      Get.testMode = true;
      Get.put(SignInViewModel());

      await tester.pumpWidget(
        GetMaterialApp(
          home: SignIn(),
        ),
      );

      expect(find.text('Or continue with'), findsOneWidget);
      expect(find.byIcon(Icons.apple), findsOneWidget);
      expect(find.byIcon(Icons.facebook), findsOneWidget);
    });
  });
}
