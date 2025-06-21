import 'package:LekkiGardens/base/base_view.dart';
import 'package:LekkiGardens/features/intro/onboarding/onboarding_view_model.dart';
import 'package:flutter/material.dart';

class Onboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      onInit: (OnboardingViewModel viewModel) {},
      onResumed: (OnboardingViewModel viewModel) {},
      onPaused: (OnboardingViewModel viewModel) {},
      onInternetConnected: (OnboardingViewModel viewModel) {},
      onInternetDisconnected: (OnboardingViewModel viewModel) {},
      onDispose: (OnboardingViewModel viewModel) {},
      view: _buildView,
    );
  }

  Widget _buildView(BuildContext context, OnboardingViewModel viewModel) {
    return Scaffold();
  }
}
