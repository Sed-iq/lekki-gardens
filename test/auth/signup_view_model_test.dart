import 'package:flutter_test/flutter_test.dart';
import 'package:LekkiGardens/features/auth/signup/sign_up_view_model.dart';

void main() {
  group('SignUpViewModel Tests', () {
    late SignUpViewModel viewModel;

    setUp(() {
      viewModel = SignUpViewModel();
    });

    test('should initialize with terms agreement as false', () {
      expect(viewModel.termsAgreementListener.value, false);
    });

    test('should toggle terms agreement state', () {
      viewModel.termsAgreementListener.value = true;
      expect(viewModel.termsAgreementListener.value, true);
    });

    test('should have required text controllers', () {
      expect(viewModel.emailController, isNotNull);
      expect(viewModel.passwordController, isNotNull);
      expect(viewModel.repeatPasswordController, isNotNull);
    });
  });
}