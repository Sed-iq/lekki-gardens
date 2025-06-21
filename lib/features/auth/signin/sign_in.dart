import 'package:LekkiGardens/base/base_view.dart';
import 'package:LekkiGardens/features/auth/signin/sign_in_view_model.dart';
import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      onInit: (SignInViewModel viewModel) {},
      onResumed: (SignInViewModel viewModel) {},
      onPaused: (SignInViewModel viewModel) {},
      onInternetConnected: (SignInViewModel viewModel) {},
      onInternetDisconnected: (SignInViewModel viewModel) {},
      onDispose: (SignInViewModel viewModel) {},
      view: _buildView,
    );
  }

  Widget _buildView(BuildContext context, SignInViewModel viewModel) {
    return Scaffold();
  }
}
