import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../common/view/loading_overlay.dart';
import 'color_utils.dart';
import 'font_weight_utils.dart';

class DisplayUtils{

  static void showCustomSnackbar(BuildContext context, String message, IconData icon, Color backgroundcolor, Color messagecolor, Duration duration){
    Flushbar(
      message:  message,
      icon: Icon(icon, size: 28.0, color: messagecolor),
      backgroundColor: backgroundcolor,
      messageColor: messagecolor,
      margin: EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      duration: duration,
    ).show(context);
  }


  static void showInternetSnackbar(BuildContext context) {
    DisplayUtils.showCustomSnackbar(context, "Back online", Icons.wifi_outlined, ColorUtils.FlushbarSuccessColor, ColorUtils.FlushbarTextColor, Duration(seconds: 4));
  }

  static void showNoInternetSnackbar(BuildContext context) {
    DisplayUtils.showCustomSnackbar(context, "No internet connection", Icons.wifi_off_outlined, ColorUtils.FlushbarErrorColor, ColorUtils.FlushbarTextColor, Duration(seconds: 4));
  }

  static void showSuccessSnackbar(BuildContext context, String message) {
    DisplayUtils.showCustomSnackbar(context, message, Icons.check_circle_outline_rounded, ColorUtils.FlushbarSuccessColor, ColorUtils.FlushbarTextColor, Duration(seconds: 4));
  }

  static void showWarningSnackbar(BuildContext context, String message) {
    DisplayUtils.showCustomSnackbar(context, message, Icons.cancel_outlined, ColorUtils.FlushbarWarningColor, ColorUtils.FlushbarTextColor, Duration(seconds: 4));
  }

  static Widget showCustomLoading({required BuildContext context, required bool isFullScreen, required Widget child, required bool isLoading, required int? progressPercent}){
    return LoadingOverlay(isLoading: isLoading, color: ColorUtils.LoadingOverlayColor, addBlur: (progressPercent != null) ? true : false, opacity: 0, child: child,
        progressIndicator: Padding(padding: EdgeInsets.only(top: isFullScreen ? AppBar().preferredSize.height : 0),
            child: (progressPercent == null) ? SpinKitWave(color: ColorUtils.PrimaryColor) :
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Material(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LinearPercentIndicator(
                          animation: false,
                          lineHeight: 20,
                          percent: (progressPercent/100),
                          center: Text("${progressPercent}%", style: TextStyle(fontWeight: FontWeightUtils.Regular, fontSize: 14)),
                          barRadius: Radius.circular(16),
                          progressColor: ColorUtils.PrimaryColor),
                      SizedBox(height: 8),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text("Upload is in progress...", style: TextStyle(fontSize: 13, fontWeight: FontWeightUtils.LightRegular, color: ColorUtils.PrimaryColor), textAlign: TextAlign.center),
                      )
                    ],
                  ),
                ))));
  }

}