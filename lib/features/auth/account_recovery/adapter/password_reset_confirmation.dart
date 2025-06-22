import 'package:LekkiGardens/common/view/common_view_utils.dart';
import 'package:LekkiGardens/utils/color_utils.dart';
import 'package:LekkiGardens/utils/font_weight_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class PasswordResetConfirmation extends StatelessWidget {
  const PasswordResetConfirmation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 20.h),
      decoration: BoxDecoration(color: ColorUtils().BackgroundOverlayColor, borderRadius: BorderRadius.circular(11.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_box_rounded, size: 70, color: ColorUtils.PrimaryColor),
          SizedBox(height: 20.h),
          Text(
            "New Password Set Successfully",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24.w, fontWeight: FontWeightUtils.LightBold, color: ColorUtils.SecondaryColor),
          ),
          SizedBox(height: 10.h),
          Text(
            "Your password has been created",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15.w),
          ),
          SizedBox(height: 35.h),
          CommonViewUtils.buildPrimaryButton(context, "Continue", () => Get.back()),
        ],
      ),
    );
  }
}
