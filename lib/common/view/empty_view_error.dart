import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/color_utils.dart';
import '../../utils/font_weight_utils.dart';
import '../model/empty_view_error_model.dart';
import 'common_view_utils.dart';

class EmptyViewError extends StatelessWidget {
  final EmptyViewErrorModel emptyViewErrorModel;

  EmptyViewError({required this.emptyViewErrorModel});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(emptyViewErrorModel.errorImage!, width: 120.w, height: 120.h),
            (emptyViewErrorModel.errorTitle != null) ?
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
              child: Text(emptyViewErrorModel.errorTitle!, style: TextStyle(fontSize: 20.sp, color: ColorUtils().ActiveColor, fontWeight: FontWeightUtils.Bold), textAlign: TextAlign.center),
            ) : SizedBox.shrink(),
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 8.h),
              child: Text(emptyViewErrorModel.errorMessage, style: TextStyle(fontSize: 14.sp, color: ColorUtils().InActiveColor, fontWeight: FontWeightUtils.LightRegular), textAlign: TextAlign.center),
            )
          ],
        ),
      ),
    );
  }
}
