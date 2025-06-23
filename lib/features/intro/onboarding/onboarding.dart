import 'package:LekkiGardens/base/base_view.dart';
import 'package:LekkiGardens/common/view/common_view_utils.dart';
import 'package:LekkiGardens/features/intro/onboarding/onboarding_view_model.dart';
import 'package:LekkiGardens/utils/color_utils.dart';
import 'package:LekkiGardens/utils/data_utils.dart';
import 'package:LekkiGardens/utils/font_weight_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      onInit: (OnboardingViewModel viewModel) {
        // viewModel.initializeControllers();
      },
      onResumed: (OnboardingViewModel viewModel) {},
      onPaused: (OnboardingViewModel viewModel) {},
      onInternetConnected: (OnboardingViewModel viewModel) {},
      onInternetDisconnected: (OnboardingViewModel viewModel) {},
      onDispose: (OnboardingViewModel viewModel) {
        viewModel.disposeControllers();
      },
      view: _buildView,
    );
  }

  Widget _buildView(BuildContext context, OnboardingViewModel viewModel) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: PageView.builder(
              controller: viewModel.backgroundController,
              itemCount: DataUtils.onBoardingList.length,
              onPageChanged: (value) => viewModel.onBackgroundPageChanged(value),
              itemBuilder: (context, index) => Image.asset(DataUtils.onBoardingList.elementAt(index).image, fit: BoxFit.cover),
            ),
            bottom: 150,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 400,
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 50.w),
              decoration: BoxDecoration(
                image: DecorationImage(fit: BoxFit.fill, alignment: Alignment.center, image: AssetImage("assets/rect.png")),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 72.h),
                  Center(
                    child: SmoothPageIndicator(
                      effect: ExpandingDotsEffect(dotHeight: 10, activeDotColor: ColorUtils.SecondaryColor, dotColor: ColorUtils.PrimaryLightColor, dotWidth: 10),
                      controller: viewModel.pageController,
                      count: DataUtils.onBoardingList.length,
                    ),
                  ),
                  Flexible(
                    child: PageView.builder(
                      controller: viewModel.pageController,
                      onPageChanged: (value) => viewModel.onContentPageChanged(value),
                      itemCount: DataUtils.onBoardingList.length,
                      itemBuilder: (context, index) => Column(
                        children: [
                          SizedBox(height: 30.h),
                          Text(
                            DataUtils.onBoardingList.elementAt(index).title,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: ColorUtils.SecondaryColor, fontSize: 30.sp, fontWeight: FontWeightUtils.LightBold),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            DataUtils.onBoardingList.elementAt(index).description,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 17.sp, color: ColorUtils().InActiveColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      (viewModel.currentOnboardingListener.value > 0)
                          ? CommonViewUtils.buildCustomOutlineButton(
                              context: context,
                              outlineColor: ColorUtils.GraySlightColor,
                              radius: 100.r,
                              onClick: () => viewModel.previousPage(),
                              child: Icon(Icons.arrow_back, size: 20.dm, color: ColorUtils().InActiveColor),
                            )
                          : SizedBox.shrink(),
                      (viewModel.currentOnboardingListener.value > 0) ? SizedBox(width: 20.w) : SizedBox.shrink(),
                      Expanded(
                        child: CommonViewUtils.buildPrimaryButton(
                          context,
                          (viewModel.currentOnboardingListener.value == DataUtils.onBoardingList.length - 1) ? "Let's Get Started" : 'Next',
                          () => viewModel.nextPage(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  RichText(
                    text: TextSpan(
                      text: 'Already have an account? ',
                      children: [
                        TextSpan(
                          text: "Sign in",
                          recognizer: TapGestureRecognizer()..onTap = () => viewModel.navigateToSignIN(),
                          style: TextStyle(color: ColorUtils.SecondaryColor),
                        ),
                      ],
                      style: TextStyle(color: ColorUtils().InActiveColor, fontFamily: "Outfit", fontSize: 13.sp),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15.h),
                  (viewModel.currentOnboardingListener.value != DataUtils.onBoardingList.length - 1)
                      ? GestureDetector(
                          onTap: () => viewModel.skipOnboarding(),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Skip",
                                  style: TextStyle(fontWeight: FontWeightUtils.Regular, color: ColorUtils.PrimaryColor, fontSize: 17.sp),
                                ),
                                SizedBox(width: 8.w),
                                Icon(Icons.arrow_forward_rounded, color: ColorUtils.PrimaryColor, size: 19),
                              ],
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
