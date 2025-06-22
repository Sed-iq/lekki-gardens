import 'package:LekkiGardens/base/base_view.dart';
import 'package:LekkiGardens/common/view/common_view_utils.dart';
import 'package:LekkiGardens/features/auth/account_recovery/account_recovery_view_model.dart';
import 'package:LekkiGardens/utils/color_utils.dart';
import 'package:LekkiGardens/utils/common_widget_utils.dart';
import 'package:LekkiGardens/utils/data_utils.dart';
import 'package:LekkiGardens/utils/enum_data_utils.dart';
import 'package:LekkiGardens/utils/font_weight_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AccountRecovery extends StatelessWidget {
  const AccountRecovery({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
      onInit: (AccountRecoveryViewModel viewModel) {},
      onResumed: (AccountRecoveryViewModel viewModel) {},
      onPaused: (AccountRecoveryViewModel viewModel) {},
      onInternetConnected: (AccountRecoveryViewModel viewModel) {},
      onInternetDisconnected: (AccountRecoveryViewModel viewModel) {},
      onDispose: (AccountRecoveryViewModel viewModel) {},
      view: _buildView,
    );
  }

  Widget _buildView(BuildContext context, AccountRecoveryViewModel viewModel) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  CommonViewUtils.buildBackButton(),
                  // Positioned(
                  //   right: 0,
                  //   left: 0,
                  //   top: 0,
                  //   bottom: 0,
                  //   child: Center(
                  //     child: SmoothPageIndicator(
                  //       effect: ExpandingDotsEffect(dotHeight: 10, activeDotColor: ColorUtils.SecondaryColor, dotColor: ColorUtils.PrimaryLightColor, dotWidth: 10),
                  //       controller: viewModel.pageController,
                  //       count: DataUtils.onBoardingList.length,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              Expanded(child: _viewStateManager(context, viewModel)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _viewStateManager(BuildContext context, AccountRecoveryViewModel viewModel) {
    switch (viewModel.account_recovery_state.value) {
      case AccountRecoveryState.EMAIL:
        return _buildEmailIdView(context, viewModel);
      case AccountRecoveryState.OTP:
        return _buildOTPView(context, viewModel);
      case AccountRecoveryState.PASSWORD_CHANGE:
        return _buildResetPassword(context, viewModel);
    }
  }

  Widget _buildEmailIdView(BuildContext context, AccountRecoveryViewModel viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 85,
          height: 85,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(99.r), color: ColorUtils.GraySlightColor),
          child: Icon(Icons.email_rounded, size: 45, color: ColorUtils.PrimaryColor),
        ),
        SizedBox(height: 22.h),
        Text(
          "Forget Password",
          style: TextStyle(fontWeight: FontWeightUtils.LightBold, color: ColorUtils.SecondaryColor, fontSize: 30.sp),
        ),
        SizedBox(height: 10.h),
        Text(
          "It was popularised in the 1960s with the release of Letraset sheetscontaining Lorem Ipsum.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14.8.sp),
        ),
        SizedBox(height: 18.h),
        CommonWidgetUtils<AccountRecoveryViewModel>().buildGenericTextField(
          context,
          viewModel,
          null,
          null,
          "Email ID/Mobile Number",
          viewModel.emailController,
          true,
          TextInputType.emailAddress,
          null,
          null,
        ),
        SizedBox(height: 45.h),
        CommonViewUtils.buildPrimaryButton(context, 'Continue', () => viewModel.nextState(AccountRecoveryState.OTP)),
      ],
    );
  }

  Widget _buildOTPView(BuildContext context, AccountRecoveryViewModel viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 85,
          height: 85,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(99.r), color: ColorUtils.GraySlightColor),
          child: Icon(Icons.email_rounded, size: 45, color: ColorUtils.PrimaryColor),
        ),
        SizedBox(height: 22.h),
        Text(
          "Enter OTP",
          style: TextStyle(fontWeight: FontWeightUtils.LightBold, color: ColorUtils.SecondaryColor, fontSize: 30.sp),
        ),
        SizedBox(height: 10.h),
        Text(
          "Enter the OTP code we just sent you on your registered Email/Phone number",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14.8.sp),
        ),
        SizedBox(height: 18.h),
        CommonWidgetUtils<AccountRecoveryViewModel>().buildOTPTextField(
          fieldNumber: 5,
          bgColor: ColorUtils.GraySlightColor,
          controller: viewModel.otpCodeController,
          viewModel: viewModel,
        ),
        SizedBox(height: 45.h),
        CommonViewUtils.buildPrimaryButton(context, 'Reset Password', () => viewModel.nextState(AccountRecoveryState.PASSWORD_CHANGE)),
        SizedBox(height: 25.h),
        Align(
          alignment: Alignment.center,
          child: RichText(
            text: TextSpan(
              text: "Didn't get OTP? ",
              children: [
                TextSpan(
                  text: "Resend OTP",
                  style: TextStyle(color: ColorUtils.SecondaryColor, decoration: TextDecoration.underline),
                ),
              ],
              style: TextStyle(color: ColorUtils().InActiveColor, fontFamily: "Outfit", fontSize: 15.sp),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildResetPassword(BuildContext context, AccountRecoveryViewModel viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 85,
          height: 85,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(99.r), color: ColorUtils.GraySlightColor),
          child: Icon(Iconsax.lock_1_bold, size: 45, color: ColorUtils.PrimaryColor),
        ),
        SizedBox(height: 22.h),
        Text(
          "Reset Password",
          style: TextStyle(fontWeight: FontWeightUtils.LightBold, color: ColorUtils.SecondaryColor, fontSize: 30.sp),
        ),
        SizedBox(height: 10.h),
        Text(
          "It was popularised in the 1960s with the release of Letraset sheetscontaining Lorem Ipsum.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14.8.sp),
        ),
        SizedBox(height: 18.h),
        CommonWidgetUtils().buildPasswordTextField(context, viewModel, null, null, "New password", viewModel.passwordController, true),
        SizedBox(height: 15.h),
        CommonWidgetUtils().buildPasswordTextField(
          context,
          Get.put(AccountRecoveryViewModel(), tag: 'confirm-password'),
          null,
          null,
          "Confirm password",
          viewModel.repeatPasswordController,
          true,
        ),
        SizedBox(height: 45.h),
        CommonViewUtils.buildPrimaryButton(context, 'Continue', () => viewModel.showConfirmation(context)),
      ],
    );
  }
}
