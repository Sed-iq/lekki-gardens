import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:LekkiGardens/features/auth/account_recovery/account_recovery.dart';
import 'package:LekkiGardens/features/auth/account_recovery/account_recovery_view_model.dart';
import 'package:LekkiGardens/utils/enum_data_utils.dart';

void main() {
  group('AccountRecovery Widget Tests', () {
    testWidgets('should display email recovery view initially', (WidgetTester tester) async {
      Get.testMode = true;
      Get.put(AccountRecoveryViewModel());

      await tester.pumpWidget(
        GetMaterialApp(
          home: AccountRecovery(),
        ),
      );

      expect(find.text('Forget Password'), findsOneWidget);
      expect(find.text('Email ID/Mobile Number'), findsOneWidget);
      expect(find.text('Continue'), findsOneWidget);
    });

    testWidgets('should display OTP view when state changes', (WidgetTester tester) async {
      Get.testMode = true;
      final viewModel = Get.put(AccountRecoveryViewModel());
      viewModel.account_recovery_state.value = AccountRecoveryState.OTP;

      await tester.pumpWidget(
        GetMaterialApp(
          home: AccountRecovery(),
        ),
      );

      expect(find.text('Enter OTP'), findsOneWidget);
      expect(find.text('Enter the OTP code we just sent you'), findsOneWidget);
      expect(find.text('Reset Password'), findsOneWidget);
    });

    testWidgets('should display password reset view', (WidgetTester tester) async {
      Get.testMode = true;
      final viewModel = Get.put(AccountRecoveryViewModel());
      viewModel.account_recovery_state.value = AccountRecoveryState.PASSWORD_CHANGE;

      await tester.pumpWidget(
        GetMaterialApp(
          home: AccountRecovery(),
        ),
      );

      expect(find.text('Reset Password'), findsOneWidget);
      expect(find.text('New password'), findsOneWidget);
      expect(find.text('Confirm password'), findsOneWidget);
    });
  });
}
