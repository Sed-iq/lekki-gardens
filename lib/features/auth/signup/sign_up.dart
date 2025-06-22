import 'package:LekkiGardens/base/base_view.dart';
import 'package:LekkiGardens/common/view/common_view_utils.dart';
import 'package:LekkiGardens/features/auth/signup/sign_up_view_model.dart';
import 'package:LekkiGardens/utils/color_utils.dart';
import 'package:LekkiGardens/utils/common_widget_utils.dart';
import 'package:LekkiGardens/utils/font_weight_utils.dart';
import 'package:LekkiGardens/utils/route_constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:get/utils.dart';
import 'package:icons_plus/icons_plus.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
      onInit: (SignUpViewModel viewModel) {},
      onResumed: (SignUpViewModel viewModel) {},
      onPaused: (SignUpViewModel viewModel) {},
      onInternetConnected: (SignUpViewModel viewModel) {},
      onInternetDisconnected: (SignUpViewModel viewModel) {},
      onDispose: (SignUpViewModel viewModel) {},
      view: _buildView,
    );
  }

  Widget _buildView(BuildContext context, SignUpViewModel viewModel) {
    return Scaffold(
      body: SafeArea(
        child: CommonViewUtils.buildDisallowIndicator(
          child: CommonViewUtils.buildCustomSingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonViewUtils.buildBackButton(),
                SizedBox(height: 15.h),
                Text(
                  "Create Account",
                  style: TextStyle(fontSize: 33.sp, color: ColorUtils.SecondaryColor, fontWeight: FontWeightUtils.Bold),
                ),
                Text(
                  'Enter your information and let’s get started',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.sp),
                ),
                SizedBox(height: 25.h),
                CommonWidgetUtils<SignUpViewModel>().buildFullNameTextField(context, viewModel, null, null, null, null, "First Name", 'Last Name'),
                SizedBox(height: 25.h),
                CommonWidgetUtils<SignUpViewModel>().buildEmailTextField(context, viewModel, null, null, "Email Address", viewModel.emailController, true),
                SizedBox(height: 25.h),
                CommonWidgetUtils<SignUpViewModel>().buildPasswordTextField(context, viewModel, null, null, "Password", viewModel.passwordController, true),
                SizedBox(height: 25.h),
                CommonWidgetUtils<SignUpViewModel>().buildPasswordTextField(
                  context,
                  Get.put(SignUpViewModel(), tag: 'repeat-password'),
                  null,
                  null,
                  "Confirm Password",
                  viewModel.repeatPasswordController,
                  true,
                ),
                SizedBox(height: 10.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: viewModel.termsAgreementListener.value,
                      side: BorderSide(color: ColorUtils.GrayDarkColor),
                      activeColor: ColorUtils.PrimaryColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(9.r)),
                      onChanged: (value) {
                        viewModel.termsAgreementListener.value = value ?? false;
                      },
                    ),
                    SizedBox(width: 5.w),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'By creating an account, you agree to the ',
                          children: [
                            TextSpan(
                              text: 'Terms',
                              style: TextStyle(color: ColorUtils.SecondaryColor),
                            ),
                            TextSpan(text: ' and '),
                            TextSpan(
                              text: 'Poilices',
                              style: TextStyle(color: ColorUtils.SecondaryColor),
                            ),
                          ],
                          style: TextStyle(fontSize: 14.sp, fontFamily: "Outfit", color: ColorUtils().ActiveColor),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25.h),
                CommonViewUtils.buildPrimaryButton(context, 'Sign up', () => null),
                SizedBox(height: 15.h),
                _buildAlternativeSignUp(context, viewModel),
                SizedBox(height: 15.h),
                Align(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      text: 'Already have an account? ',
                      children: [
                        TextSpan(
                          text: "Sign in",
                          recognizer: TapGestureRecognizer()..onTap = () => Get.toNamed(RouteConstants.SIGNIN),
                          style: TextStyle(color: ColorUtils.SecondaryColor, decoration: TextDecoration.underline),
                        ),
                      ],
                      style: TextStyle(color: ColorUtils().InActiveColor, fontFamily: "Outfit", fontSize: 15.sp),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAlternativeSignUp(BuildContext context, SignUpViewModel viewModel) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: Colors.grey[300], thickness: 1)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                'Or sign up with',
                style: TextStyle(color: Colors.grey[600], fontSize: 14.sp, fontWeight: FontWeight.w400),
              ),
            ),
            Expanded(child: Divider(color: Colors.grey[300], thickness: 1)),
          ],
        ),
        SizedBox(height: 24.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Google button
            GestureDetector(
              // onTap: () => _signUpWithGoogle(),
              child: Container(
                width: 65.w,
                height: 70.h,
                decoration: BoxDecoration(color: ColorUtils.GraySlightColor, borderRadius: BorderRadius.circular(20.r)),
                child: Center(child: Brand(Brands.google, size: 28)),
              ),
            ),
            SizedBox(width: 25.w),
            GestureDetector(
              // onTap: () => _signUpWithApple(),
              child: Container(
                width: 65.w,
                height: 70.h,
                decoration: BoxDecoration(color: ColorUtils.GraySlightColor, borderRadius: BorderRadius.circular(20.r)),
                child: Center(child: Icon(Icons.apple, size: 28, color: Colors.black)),
              ),
            ),
            SizedBox(width: 25.w),
            GestureDetector(
              // onTap: () => _signUpWithFacebook(),
              child: Container(
                width: 65.w,
                height: 70.h,
                decoration: BoxDecoration(color: ColorUtils.GraySlightColor, borderRadius: BorderRadius.circular(20.r)),
                child: Center(child: Icon(Icons.facebook, size: 28, color: Color(0xFF1877F2))),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
