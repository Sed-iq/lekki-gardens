import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:LekkiGardens/features/auth/account_recovery/account_recovery_view_model.dart';
import 'package:LekkiGardens/utils/enum_data_utils.dart';

void main() {
  group('AccountRecoveryViewModel Tests', () {
    late AccountRecoveryViewModel viewModel;

    setUp(() {
      viewModel = AccountRecoveryViewModel();
    });

    test('should initialize with EMAIL state', () {
      expect(viewModel.account_recovery_state.value, AccountRecoveryState.EMAIL);
    });

    test('should change to OTP state', () {
      viewModel.nextState(AccountRecoveryState.OTP);
      expect(viewModel.account_recovery_state.value, AccountRecoveryState.OTP);
    });

    test('should change to PASSWORD_CHANGE state', () {
      viewModel.nextState(AccountRecoveryState.PASSWORD_CHANGE);
      expect(viewModel.account_recovery_state.value, AccountRecoveryState.PASSWORD_CHANGE);
    });

    test('should have required text controllers', () {
      expect(viewModel.emailController, isNotNull);
      expect(viewModel.otpCodeController, isNotNull);
      expect(viewModel.passwordController, isNotNull);
      expect(viewModel.repeatPasswordController, isNotNull);
    });
  });
}