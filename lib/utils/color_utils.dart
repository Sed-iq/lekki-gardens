import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ColorUtils {
  static const PrimaryColor = Color(0xFF0B5240);
  static const PrimaryLightColor = Color(0x8045AA91);
  static const LoadingOverlayColor = Color(0xFFEAEAEA);
  Color AppBarBackgroundColor = (!Get.isDarkMode) ? Color(0xFFFFFFFF) : Color(0xFF010E0E);
  Color BackgroundColor = (!Get.isDarkMode) ? Color(0xFFFBFBFB) : Color(0xFF323232);
  Color BackgroundOverlayColor = (!Get.isDarkMode) ? Color(0xFFFFFFFF) : Color(0xFF000000);
  Color CardBackgroundColor = (!Get.isDarkMode) ? Color(0xFFFCFCFC) : Color(0xFF1E1E1E);
  Color CardBorderColor = (!Get.isDarkMode) ? Color(0x9EEDEDED) : Color(0xFF1E1E1E);
  Color BottomSheetBackgroundColor = (!Get.isDarkMode) ? Color(0xFFFFFFFF) : Color(0xFF010E0E);
  Color ActiveColor = (!Get.isDarkMode) ? Color(0xFF010E0E) : Color(0xFFFFFFFF);
  Color InActiveColor = (!Get.isDarkMode) ? Color(0xFF828282) : Color(0xFFE4E4E4);
  Color TextFieldTitleColor = (!Get.isDarkMode) ? Color(0xFF616161) : Color(0xFFE4E4E4);
  Color TextFieldHintColor = (!Get.isDarkMode) ? Color(0xFFAAAAAA) : Color(0xFFE4E4E4);
  Color TextFieldBackgroundColor = (!Get.isDarkMode) ? Color(0xFFFAFAFA) : Color(0xFF424242);
  Color TextFieldDisableBackgroundColor = (!Get.isDarkMode) ? Color(0xFFFAFAFA) : Color(0xFF282828);
  Color TextFieldBorderColor = (!Get.isDarkMode) ? Color(0xFFE2E2E2) : Color(0xFF171717);
  Color TextFieldErrorColor = (!Get.isDarkMode) ? Color(0xFFCF000F) : Color(0xFFCF000F);
  static const WhiteColor = Color(0xFFFFFFFF);
  static const BlackColor = Color(0xFF000000);
  static const GraySlightColor = Color(0xFFE4E4E4);
  static const GrayDarkColor = Color(0xFF79747E);
  static const StarRatingColor = Color(0xFFfdd835);
  static const ErrorRed = Color(0xFFff0000);
  static const BlueColor = Color(0xFF0784CA);
  static const FadedBlueColor = Color(0xFF399dd5);

  //Custom Flushbar Colors
  static const FlushbarSuccessColor = Color(0xff2D6A4F);
  static const FlushbarInfoColor = Color(0xffFCA652);
  static const FlushbarErrorColor = Color(0xffc72c41);
  static const FlushbarWarningColor = Color(0xFFF0541E);
  static const FlushbarTextColor = Color(0xFFffffff);

  // Plush Colors
  static const SecondaryColor = Color(0xFF16977E);
}
