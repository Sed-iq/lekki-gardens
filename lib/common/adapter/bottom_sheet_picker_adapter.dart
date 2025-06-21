import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:LekkiGardens/utils/enum_data_utils.dart';
import '../../utils/color_utils.dart';
import '../../utils/font_weight_utils.dart';
import '../model/bottom_sheet_picker_model.dart';
import '../view/common_view_utils.dart';

class BottomSheetPickerAdapter extends StatelessWidget {
  final BottomSheetPickerModel bottomSheetPickerModel;
  final BottomSheetPickerModel? selectedBottomSheetPicker;
  final Function(BottomSheetPickerModel) onItemClickListener;

  BottomSheetPickerAdapter({required this.bottomSheetPickerModel, this.selectedBottomSheetPicker, required this.onItemClickListener});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      onTap: () {
        if (bottomSheetPickerModel.enabled) {
          onItemClickListener(bottomSheetPickerModel);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(vertical: 7.h),
              child: Container(
                  decoration: (selectedBottomSheetPicker != null && selectedBottomSheetPicker!.value == bottomSheetPickerModel.value) ? BoxDecoration(borderRadius: BorderRadius.circular(8.r), color: ColorUtils.GraySlightColor) : null,
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
                  child: Row(
                    children: [
                      (bottomSheetPickerModel.imageType != null && bottomSheetPickerModel.image != null)
                          ? Padding(
                              padding: EdgeInsets.only(right: 5.w),
                              child: (bottomSheetPickerModel.imageType == ImageType.SVG)
                                  ? SvgPicture.asset(bottomSheetPickerModel.image!, width: 53.w, height: 53.h)
                                  : (bottomSheetPickerModel.imageType == ImageType.SVGNETWORK)
                                      ? SvgPicture.network(bottomSheetPickerModel.image!, width: 53.w, height: 53.h)
                                      : (bottomSheetPickerModel.enabled)
                                          ? CommonViewUtils.CircleCachedNetworkImage(imageUrl: bottomSheetPickerModel.image!, width: 53.w, height: 53.h)
                                          : CommonViewUtils.CircleCachedNetworkImage(imageUrl: bottomSheetPickerModel.image!, width: 53.w, height: 53.h).blurred(blur: 1.3, blurColor: ColorUtils.GraySlightColor, borderRadius: BorderRadius.circular(360.r)))
                          : SizedBox.shrink(),
                      Expanded(
                          child: Row(
                        children: [
                          Expanded(child: Text(bottomSheetPickerModel.title, style: TextStyle(fontSize: 16.sp, color: ColorUtils().ActiveColor, fontWeight: FontWeightUtils.LightRegular), overflow: TextOverflow.ellipsis)),
                          (bottomSheetPickerModel.subTitle != null)
                              ? Padding(
                                  padding: EdgeInsets.only(left: 5.w),
                                  child: Text(bottomSheetPickerModel.subTitle!, style: TextStyle(fontSize: 16.sp, color: ColorUtils().InActiveColor, fontWeight: FontWeightUtils.Regular), overflow: TextOverflow.ellipsis),
                                )
                              : SizedBox.shrink()
                        ],
                      )),
                      (selectedBottomSheetPicker != null && selectedBottomSheetPicker!.value == bottomSheetPickerModel.value) ? Padding(padding: EdgeInsets.only(left: 5.w), child: Icon(Icons.arrow_forward_ios_rounded, size: 25.w)) : SizedBox.shrink()
                    ],
                  ))),
        ],
      ),
    );
  }
}
