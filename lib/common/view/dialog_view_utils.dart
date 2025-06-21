import 'package:blur/blur.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/color_utils.dart';

class DialogViewUtils {

  static CustomModalDialog({required BuildContext context, required Alignment alignment, double? margin, required bool showDecoration, required Widget child}){
    return Get.dialog(Material(
        color: Colors.transparent,
        child: Stack(
          alignment: alignment,
          children: [
            InkWell(
              splashFactory: NoSplash.splashFactory,
              onTap: (){
                Get.back();
              },
              child: Blur(
                blur: 1.8.dm,
                blurColor: ColorUtils.BlackColor,
                colorOpacity: 0.1,
                child: SafeArea(child: SizedBox(height: Get.height, width: Get.width)),
              ),
            ),
            SafeArea(child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: margin ?? 0.0),
                decoration: (showDecoration) ? BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(42.r)), color: ColorUtils().BottomSheetBackgroundColor) : null,
                width: Get.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    child
                  ],
                )
            ))
          ],
        )
    ));
  }

}