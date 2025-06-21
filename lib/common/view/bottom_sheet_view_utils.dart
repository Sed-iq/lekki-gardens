import 'package:blur/blur.dart';
import 'package:LekkiGardens/utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:LekkiGardens/common/model/empty_view_error_model.dart';
import 'package:LekkiGardens/common/view/empty_view_error.dart';

import '../../base/base_view_model.dart';
import '../../utils/color_utils.dart';
import '../../utils/display_utils.dart';
import '../../utils/font_weight_utils.dart';
import '../adapter/bottom_sheet_picker_adapter.dart';
import '../model/bottom_sheet_picker_model.dart';

class BottomSheetViewUtils {
  static Future<void> CustomModalBottomSheet<T extends BaseViewModel>({required BuildContext context, required bool showFullBottomSheet, bool? isDismissible, required Widget child}) {
    CommonUtils.closeKeyboard(context);
    return Get.bottomSheet(
      Stack(
        alignment: Alignment.bottomCenter,
        children: [
          InkWell(
            splashFactory: NoSplash.splashFactory,
            onTap: () {
              if ((isDismissible ?? true)) {
                Get.back();
              }
            },
            child: Blur(
              blur: 1.8.dm,
              blurColor: ColorUtils.BlackColor,
              colorOpacity: 0.1,
              child: SafeArea(
                child: SizedBox(height: Get.height, width: Get.width),
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(24.r), topLeft: Radius.circular(24.r)),
                color: ColorUtils().BottomSheetBackgroundColor,
              ),
              width: Get.width,
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: ColorUtils.GrayDarkColor),
                      margin: EdgeInsets.symmetric(vertical: 16.h),
                      width: 40.w,
                      height: 6.h,
                    ),
                    Container(
                      height: (!showFullBottomSheet) ? Get.height / 2 : null,
                      child: GetX<T>(
                        builder: (baseViewModel) {
                          return WillPopScope(
                            onWillPop: () async => !baseViewModel.isBottomSheetNetworkLoading.value,
                            child: DisplayUtils.showCustomLoading(
                              isLoading: baseViewModel.isBottomSheetNetworkLoading.value,
                              isFullScreen: false,
                              context: context,
                              progressPercent: null,
                              child: child,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      useRootNavigator: true,
      isDismissible: true,
      isScrollControlled: true,
      ignoreSafeArea: false,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(0), topLeft: Radius.circular(0)),
      ),
    );
  }

  static showCustomBottomSheetPicker({
    required BuildContext context,
    required String title,
    required List<BottomSheetPickerModel> bottomSheetPickerDataList,
    required bool showFullBottomSheet,
    BottomSheetPickerModel? selectedBottomSheetPicker,
    required Function(BottomSheetPickerModel) onItemClickListener,
  }) {
    CommonUtils.closeKeyboard(context);
    CustomModalBottomSheet(
      context: context,
      showFullBottomSheet: showFullBottomSheet,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18.sp, color: ColorUtils().ActiveColor, fontWeight: FontWeightUtils.LightBold),
          ),
          SizedBox(height: 20.h),
          Expanded(
            flex: (showFullBottomSheet) ? 0 : 1,
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowIndicator();
                return true;
              },
              child: (bottomSheetPickerDataList.isNotEmpty)
                  ? ListView.builder(
                      itemBuilder: (listContext, index) {
                        return BottomSheetPickerAdapter(
                          bottomSheetPickerModel: bottomSheetPickerDataList.elementAt(index),
                          selectedBottomSheetPicker: selectedBottomSheetPicker,
                          onItemClickListener: (pickerBottomSheetModel) {
                            Get.back();
                            onItemClickListener(pickerBottomSheetModel);
                          },
                        );
                      },
                      padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 10.h),
                      itemCount: bottomSheetPickerDataList.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                    )
                  : EmptyViewError(
                      emptyViewErrorModel: EmptyViewErrorModel(errorImage: "assets/ic_empty.svg", errorMessage: "Oops there's nothing here..."),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
