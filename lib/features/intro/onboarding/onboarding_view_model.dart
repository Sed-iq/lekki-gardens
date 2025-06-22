import 'package:LekkiGardens/utils/data_utils.dart';
import 'package:LekkiGardens/utils/route_constants.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../../../base/base_view_model.dart';

class OnboardingViewModel extends BaseViewModel {
  RxInt currentOnboardingListener = 0.obs;
  PageController pageController = PageController();

  late PageController backgroundController;
  bool isBackgroundScrolling = false;
  bool isContentScrolling = false;

  void initializeControllers() {
    backgroundController = PageController();
  }

  void disposeControllers() {
    backgroundController.dispose();
  }

  void onBackgroundPageChanged(int page) {
    currentOnboardingListener.value = page;

    if (!isContentScrolling) {
      isBackgroundScrolling = true;
      pageController.animateToPage(page, duration: Duration(milliseconds: 300), curve: Curves.easeInOut).then((_) {
        isBackgroundScrolling = false;
      });
    }
  }

  void onContentPageChanged(int page) {
    currentOnboardingListener.value = page;

    if (!isBackgroundScrolling) {
      isContentScrolling = true;
      backgroundController.animateToPage(page, duration: Duration(milliseconds: 300), curve: Curves.easeInOut).then((_) {
        isContentScrolling = false;
      });
    }
  }

  void nextPage() {
    int currentPage = currentOnboardingListener.value;
    int nextPageIndex = currentPage + 1;

    if (nextPageIndex < DataUtils.onBoardingList.length) {
      pageController.animateToPage(nextPageIndex, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      navigateToSignUP();
    }
  }

  void previousPage() {
    int currentPage = currentOnboardingListener.value;
    int previousPageIndex = currentPage - 1;

    pageController.animateToPage(previousPageIndex, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void skipOnboarding() {
    completeOnboarding();
  }

  void navigateToSignUP() {
    Get.toNamed(RouteConstants.SIGNUP);
  }

  void navigateToSignIN() {
    Get.toNamed(RouteConstants.SIGNIN);
  }

  void completeOnboarding() async {
    await pageController.animateToPage(3, duration: 500.ms, curve: Curves.ease);
    Future.delayed(800.ms, () {
      navigateToSignUP();
    });
  }
}
