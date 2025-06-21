import 'package:LekkiGardens/common/view/common_view_utils.dart';
import 'package:LekkiGardens/utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:LekkiGardens/common/adapter/tab_adapter.dart';
import 'package:LekkiGardens/common/model/bottom_sheet_picker_model.dart';
import 'package:LekkiGardens/common/view/bottom_sheet_view_utils.dart';
import 'package:logger/web.dart';
import 'package:pinput/pinput.dart';

import '../../base/base_view_model.dart';
import '../../utils/color_utils.dart';
import '../../utils/font_weight_utils.dart';
import '../common/model/tab_model.dart';

class CommonWidgetUtils<T extends BaseViewModel> {
  Widget buildEmailTextField(BuildContext context, T viewModel, String? title, String? subtitle, String hint, TextEditingController emailController, bool enabled) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonViewUtils.buildTextFieldTitle(title, subtitle),
          TextField(
            controller: emailController,
            enabled: enabled,
            style: TextStyle(fontSize: 16.sp, color: ColorUtils().ActiveColor, fontWeight: FontWeightUtils.LightRegular),
            decoration: InputDecoration(
              hintText: hint,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7.r),
                borderSide: BorderSide(color: ColorUtils().TextFieldBorderColor),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7.r),
                borderSide: BorderSide(color: ColorUtils().TextFieldBorderColor),
              ),
              fillColor: ColorUtils().TextFieldBackgroundColor,
            ),
            keyboardType: TextInputType.emailAddress,
            onChanged: (email) {
              if (viewModel.emailValidation.isNotEmpty) {
                viewModel.resetNotifyListeners();
              }
            },
          ),
          CommonViewUtils.buildTextFieldErrorHint(viewModel.emailValidation),
        ],
      ),
    );
  }

  Widget buildPasswordTextField(BuildContext context, T viewModel, String? title, String? subtitle, String hint, TextEditingController passwordController, bool enabled) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonViewUtils.buildTextFieldTitle(title, subtitle),
          TextField(
            controller: passwordController,
            enabled: enabled,
            style: TextStyle(fontSize: 16.sp, color: ColorUtils().ActiveColor, fontWeight: FontWeightUtils.LightRegular),
            obscureText: viewModel.passwordHiddenToggle.value,
            decoration: InputDecoration(
              suffixIconConstraints: BoxConstraints(minWidth: 23, maxHeight: 20),
              hintText: hint,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7.r),
                borderSide: BorderSide(color: ColorUtils().TextFieldBorderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7.r),
                borderSide: BorderSide(color: ColorUtils().TextFieldBorderColor),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              fillColor: ColorUtils().TextFieldBackgroundColor,
              suffixIcon: InkWell(
                onTap: () {
                  viewModel.setPasswordHiddenToggle(!viewModel.passwordHiddenToggle.value);
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Icon((viewModel.passwordHiddenToggle.value) ? Iconsax.eye_outline : Iconsax.eye_slash_outline, size: 30.dm, color: ColorUtils().ActiveColor),
                ),
              ),
            ),
            keyboardType: TextInputType.visiblePassword,
            onChanged: (password) {
              if (viewModel.passwordValidation.isNotEmpty) {
                viewModel.resetNotifyListeners();
              }
            },
          ),
          CommonViewUtils.buildTextFieldErrorHint(viewModel.passwordValidation),
        ],
      ),
    );
  }

  Widget buildOTPTextField({
    int? fieldNumber,
    bool? obscure,
    required String title,
    required TextEditingController controller,
    MainAxisAlignment? mainAxisAlignment,
    required T viewModel,
    Color? bgColor,
    Color? borderColor,
    CrossAxisAlignment? crossAxisAlignment,
  }) {
    PinTheme theme = PinTheme(
      height: 60.h,
      width: 60.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        color: bgColor,
        border: Border.all(color: borderColor ?? ColorUtils.GrayDarkColor),
      ),
    );
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 13.w),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r), color: ColorUtils().BackgroundOverlayColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CommonViewUtils.buildTextFieldTitle(title, null),
          SizedBox(height: 5.h),
          Pinput(
            forceErrorState: (viewModel.genericTextFieldValidation.isNotEmpty),
            crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
            controller: controller,
            obscureText: obscure ?? true,
            obscuringWidget: Text(
              "*",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 19.sp, color: ColorUtils.BlackColor, fontWeight: FontWeightUtils.LightBold),
            ),
            mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
            preFilledWidget: Text(
              "-",
              style: TextStyle(fontSize: 173.sp, color: ColorUtils().InActiveColor),
            ),
            length: fieldNumber ?? 4,
            defaultPinTheme: theme,
            onChanged: (_) => viewModel.resetNotifyListeners(),
            focusedPinTheme: theme.copyWith(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(color: ColorUtils.PrimaryColor),
              ),
            ),
          ),
          CommonViewUtils.getTextFieldErrorHint(viewModel.genericTextFieldValidation),
        ],
      ),
    );
  }

  Widget buildCurrencyTextField(
    BuildContext context,
    T viewModel,
    String? title,
    String? subtitle,
    String hint,
    TextEditingController currencyTextController,
    bool enabled,
    List<TextInputFormatter>? inputFormatters,
  ) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonViewUtils.buildTextFieldTitle(title, subtitle),
          TextField(
            controller: currencyTextController,
            enabled: enabled,
            style: TextStyle(fontSize: 16.sp, color: ColorUtils().ActiveColor, fontWeight: FontWeightUtils.LightRegular),
            decoration: InputDecoration(
              hintText: hint,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7.r),
                borderSide: BorderSide(color: ColorUtils().TextFieldBorderColor),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              fillColor: ColorUtils().TextFieldBackgroundColor,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7.r),
                borderSide: BorderSide(color: ColorUtils().TextFieldBorderColor),
              ),
            ),
            inputFormatters: inputFormatters,
            keyboardType: TextInputType.number,
            onChanged: (genericText) {
              if (viewModel.genericTextFieldValidation.isNotEmpty) {
                viewModel.resetNotifyListeners();
              }
            },
          ),
          CommonViewUtils.buildTextFieldErrorHint(viewModel.currencyValidation),
        ],
      ),
    );
  }

  Widget buildPhoneNumberTextField(
    BuildContext context,
    T viewModel,
    String? title,
    String? subtitle,
    String hint,
    TextEditingController genericController,
    bool enabled,
    List<TextInputFormatter>? inputFormatters,
  ) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonViewUtils.buildTextFieldTitle(title, subtitle),
          TextField(
            controller: genericController,
            enabled: enabled,
            style: TextStyle(fontSize: 16.sp, color: ColorUtils().ActiveColor, fontWeight: FontWeightUtils.LightRegular),
            decoration: InputDecoration(
              hintText: hint,
              prefixIcon: Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '+234',
                      style: TextStyle(fontSize: 14.sp, color: ColorUtils().InActiveColor),
                    ),
                    SizedBox(width: 12.w),
                    SizedBox(height: 15, child: VerticalDivider(width: 2, color: ColorUtils().InActiveColor)),
                  ],
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7.r),
                borderSide: BorderSide(color: ColorUtils().TextFieldBorderColor),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              fillColor: ColorUtils().TextFieldBackgroundColor,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7.r),
                borderSide: BorderSide(color: ColorUtils().TextFieldBorderColor),
              ),
            ),
            inputFormatters: inputFormatters,
            keyboardType: TextInputType.number,
            onChanged: (genericText) {
              if (viewModel.phoneNumberValidation.isNotEmpty) {
                viewModel.resetNotifyListeners();
              }
            },
          ),
          CommonViewUtils.buildTextFieldErrorHint(viewModel.phoneNumberValidation),
        ],
      ),
    );
  }

  Widget buildFullNameTextField(
    BuildContext context,
    T viewModel,
    String? firstTitle,
    String? lastTitle,
    String? firstSubtitle,
    String? lastSubtitle,
    String firstHint,
    String lastHint, {
    double? spacing,
  }) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonViewUtils.buildTextFieldTitle(firstTitle, firstSubtitle),
          TextField(
            controller: viewModel.firstnameController,
            enabled: true,
            style: TextStyle(fontSize: 16.sp, color: ColorUtils().ActiveColor, fontWeight: FontWeightUtils.LightRegular),
            decoration: InputDecoration(
              hintText: firstHint,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7.r),
                borderSide: BorderSide(color: ColorUtils().TextFieldBorderColor),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              fillColor: ColorUtils().TextFieldBackgroundColor,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7.r),
                borderSide: BorderSide(color: ColorUtils().TextFieldBorderColor),
              ),
            ),
            keyboardType: TextInputType.text,
            onChanged: (genericText) {
              if (viewModel.firstNameValidation.isNotEmpty) {
                viewModel.resetNotifyListeners();
              }
            },
          ),
          CommonViewUtils.buildTextFieldErrorHint(viewModel.firstNameValidation),
          (spacing == null) ? SizedBox(height: 25.h) : SizedBox(height: spacing),
          CommonViewUtils.buildTextFieldTitle(lastTitle, lastSubtitle),
          TextField(
            controller: viewModel.lastnameController,
            enabled: true,
            style: TextStyle(fontSize: 16.sp, color: ColorUtils().ActiveColor, fontWeight: FontWeightUtils.LightRegular),
            decoration: InputDecoration(
              hintText: lastHint,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7.r),
                borderSide: BorderSide(color: ColorUtils().TextFieldBorderColor),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              fillColor: ColorUtils().TextFieldBackgroundColor,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7.r),
                borderSide: BorderSide(color: ColorUtils().TextFieldBorderColor),
              ),
            ),
            keyboardType: TextInputType.text,
            onChanged: (genericText) {
              if (viewModel.lastNameValidation.isNotEmpty) {
                viewModel.resetNotifyListeners();
              }
            },
          ),
          CommonViewUtils.buildTextFieldErrorHint(viewModel.lastNameValidation),
        ],
      ),
    );
  }

  Widget buildGenericTextField(
    BuildContext context,
    T viewModel,
    String? title,
    String? subtitle,
    String hint,
    TextEditingController genericController,
    bool enabled,
    TextInputType textInputType,
    List<TextInputFormatter>? inputFormatters, {
    Function(String value)? onChange,
  }) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonViewUtils.buildTextFieldTitle(title, subtitle),
          TextField(
            controller: genericController,
            enabled: enabled,
            maxLines: (textInputType == TextInputType.multiline) ? null : 1,
            style: TextStyle(fontSize: 16.sp, color: ColorUtils().ActiveColor, fontWeight: FontWeightUtils.LightRegular),
            decoration: InputDecoration(
              hintText: hint,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7.r),
                borderSide: BorderSide(color: ColorUtils().TextFieldBorderColor),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              fillColor: ColorUtils().TextFieldBackgroundColor,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7.r),
                borderSide: BorderSide(color: ColorUtils().TextFieldBorderColor),
              ),
            ),
            inputFormatters: inputFormatters,
            keyboardType: textInputType,
            onChanged: (genericText) {
              (onChange != null) ? onChange(genericText) : null;
              if (onChange == null)
                if (viewModel.genericTextFieldValidation.isNotEmpty) {
                  viewModel.resetNotifyListeners();
                }
            },
          ),
          CommonViewUtils.buildTextFieldErrorHint(viewModel.genericTextFieldValidation),
        ],
      ),
    );
  }

  Widget buildCustomBottomSheetPicker(BuildContext context, T viewModel, String hint, bool isBigBottomSheet, bool showFullBottomSheet, String? title, Widget view) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (title != null) ? CommonViewUtils.buildTextFieldTitle(title, null) : SizedBox.shrink(),
        InkWell(
          onTap: () {
            viewModel.resetNotifyListeners();
            BottomSheetViewUtils.CustomModalBottomSheet(context: context, showFullBottomSheet: showFullBottomSheet, child: view);
          },
          child: Container(
            decoration: BoxDecoration(
              color: ColorUtils().TextFieldBackgroundColor,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: ColorUtils().TextFieldBorderColor, width: 1.2, style: BorderStyle.solid),
            ),
            padding: (isBigBottomSheet) ? EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h) : EdgeInsets.symmetric(horizontal: 6.w, vertical: 7.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    (viewModel.bottomSheetPickerListener.value == null) ? hint : viewModel.bottomSheetPickerListener.value!.title,
                    style: TextStyle(
                      fontSize: (isBigBottomSheet) ? 16.sp : 14.sp,
                      color: (viewModel.bottomSheetPickerListener.value == null) ? ColorUtils().InActiveColor : ColorUtils().ActiveColor,
                      fontWeight: FontWeightUtils.LightRegular,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: (isBigBottomSheet) ? 3.w : 1.w),
                Icon(Icons.keyboard_arrow_down_rounded, color: ColorUtils.PrimaryColor),
              ],
            ),
          ),
        ),
        CommonViewUtils.getTextFieldErrorHint(viewModel.bottomSheetPickerValidation),
      ],
    );
  }

  Widget buildBottomSheetPicker(
    BuildContext context,
    T viewModel,
    String hint,
    bool isBigBottomSheet,
    List<BottomSheetPickerModel> bottomSheetPickerDataList,
    bool showFullBottomSheet,
    Function(BottomSheetPickerModel) selectedBottomSheetPicker, {
    String? title,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (title != null) ? CommonViewUtils.buildTextFieldTitle(title, null) : SizedBox.shrink(),
        InkWell(
          onTap: () {
            BottomSheetViewUtils.showCustomBottomSheetPicker(
              context: context,
              title: hint,
              bottomSheetPickerDataList: bottomSheetPickerDataList,
              showFullBottomSheet: showFullBottomSheet,
              selectedBottomSheetPicker: viewModel.bottomSheetPickerListener.value,
              onItemClickListener: (bottomSheetPickerModel) {
                selectedBottomSheetPicker(bottomSheetPickerModel);
                viewModel.setBottomSheetPicker(bottomSheetPickerModel);
                if (viewModel.bottomSheetPickerValidation.isNotEmpty) {
                  viewModel.resetNotifyListeners();
                }
              },
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: ColorUtils().TextFieldBackgroundColor,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: ColorUtils().TextFieldBorderColor, width: 1.2, style: BorderStyle.solid),
            ),
            padding: (isBigBottomSheet) ? EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h) : EdgeInsets.symmetric(horizontal: 6.w, vertical: 7.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    (viewModel.bottomSheetPickerListener.value == null) ? hint : viewModel.bottomSheetPickerListener.value!.title,
                    style: TextStyle(
                      fontSize: (isBigBottomSheet) ? 16.sp : 14.sp,
                      color: (viewModel.bottomSheetPickerListener.value == null) ? ColorUtils().InActiveColor : ColorUtils().ActiveColor,
                      fontWeight: FontWeightUtils.LightRegular,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: (isBigBottomSheet) ? 3.w : 1.w),
                Icon(Icons.keyboard_arrow_down_rounded, color: ColorUtils.PrimaryColor),
              ],
            ),
          ),
        ),
        CommonViewUtils.getTextFieldErrorHint(viewModel.bottomSheetPickerValidation),
      ],
    );
  }

  static Widget buildCustomSwitch(BuildContext context, bool toggle, Function(bool value) onToggle) =>
      FlutterSwitch(value: toggle, onToggle: (value) => onToggle(value), activeColor: ColorUtils.PrimaryColor, inactiveColor: ColorUtils().InActiveColor, padding: 0, height: 25.h, width: 45.w);

  Widget buildCustomTab(BuildContext context, T viewModel, TabController? tabController, List<TabModel> tabDataList, List<Widget> tabViewDataList) {
    return (tabController != null)
        ? Column(
            children: [
              TabBar(
                controller: tabController,
                splashFactory: NoSplash.splashFactory,
                indicatorColor: ColorUtils().ActiveColor,
                indicatorWeight: 4.h,
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: ColorUtils().ActiveColor,
                unselectedLabelColor: ColorUtils().InActiveColor,
                labelStyle: TextStyle(fontWeight: FontWeightUtils.Regular),
                unselectedLabelStyle: TextStyle(fontWeight: FontWeightUtils.LightRegular),
                labelPadding: EdgeInsets.symmetric(horizontal: 0.w),
                tabs: tabDataList.asMap().entries.map((entries) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 14.h),
                    child: Text(
                      entries.value.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 13.sp),
                      textAlign: TextAlign.center,
                    ),
                  );
                }).toList(),
              ),
              Divider(color: ColorUtils.GraySlightColor, thickness: 1.h, height: 0),
              SizedBox(height: 25.h),
              Expanded(
                child: TabBarView(controller: tabController, children: tabViewDataList),
              ),
            ],
          )
        : SizedBox.shrink();
  }

  Widget buildSearchTextField(BuildContext context, T viewModel, String hint, TextEditingController searchController, Function(String value) onChange) {
    return TextField(
      controller: searchController,
      style: TextStyle(fontWeight: FontWeightUtils.LightRegular, fontSize: 13.sp, color: ColorUtils().ActiveColor),
      onChanged: (value) {
        onChange(value);
      },
      decoration: InputDecoration(
        // prefixIcon: Padding(padding: EdgeInsets.only(left: 8.w, right: 12.w), child: Icon(MingCute.search_2_fill, size: 19.dm, color: ColorUtils().InActiveColor)),
        contentPadding: EdgeInsets.only(left: 20.w, right: 12.w),
        hintText: hint,
        constraints: BoxConstraints(maxHeight: 45),
        hintStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeightUtils.LightRegular, color: ColorUtils().InActiveColor),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: Colors.transparent),
          gapPadding: 0,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: new BorderSide(color: ColorUtils.PrimaryColor, width: 1.3),
          gapPadding: 0,
        ),
        fillColor: ColorUtils().TextFieldBackgroundColor,
      ),
      keyboardType: TextInputType.text,
    );
  }

  Widget buildCustomTab$(BuildContext context, T viewModel, List<TabModel> tabDataList, Function(TabModel)? callback, List<Widget> tabViewDataList) {
    return Column(
      children: [
        Container(
          height: 30.h,
          child: Stack(
            fit: StackFit.expand,
            children: [
              GetBuilder<T>(
                init: viewModel,
                builder: (T viewModel) => ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return TabAdapter(
                      index: index,
                      length: tabDataList.length,
                      selectedTabIndex: viewModel.customTabIndexListener.value,
                      tabModel: tabDataList.elementAt(index),
                      onItemClickListener:  (tabModel) {
                        viewModel.setCustomTabIndex(index);
                        if (callback != null) {
                          callback(tabModel);
                        }
                      },
                    );
                  },
                  itemCount: tabDataList.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: false,
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15.h),
        tabViewDataList.elementAt(viewModel.customTabIndexListener.value),
      ],
    );
  }
}
