import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:money_formatter/money_formatter.dart';
import 'app_constants.dart';
import 'color_utils.dart';

class CommonUtils {

  static void getSystemUIOverlayStyle(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark, //status bar brigtness
      statusBarIconBrightness: Brightness.dark, //status barIcon Brightness
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: ColorUtils().BackgroundColor,  //navigation background color
      systemNavigationBarDividerColor: Colors.transparent, //Navigation bar divider color
      systemNavigationBarIconBrightness: (!Get.isDarkMode) ? Brightness.dark : Brightness.light, //navigation bar icon
    ));
  }

  static String getClassName(Type type){
    return type.toString();
  }

  static MoneyFormatterOutput currencyFormatter(double formatter) {
    return MoneyFormatter(amount: formatter).output;
  }

  static void closeKeyboard(BuildContext context){
    if(FocusScope.of(context).isFirstFocus) {
      FocusScope.of(context).requestFocus(new FocusNode());
    }
  }

  static String getLoginToken() {
    GetStorage getStorage = Get.find<GetStorage>();
    String loginToken = getStorage.read(AppConstants.LOGIN_TOKEN) ?? "";
    return loginToken;
  }


}