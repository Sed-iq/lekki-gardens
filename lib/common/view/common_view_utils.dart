import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../utils/color_utils.dart';
import '../../utils/common_utils.dart';
import '../../utils/font_weight_utils.dart';

class CommonViewUtils {
  static Widget buildBackButton() {
    return InkWell(
      onTap: () {
        Get.back();
      },
      child: buildCustomCard(
        padding: EdgeInsets.all(10.dm),
        radius: 100.r,
        color: ColorUtils().BackgroundOverlayColor,
        child: Icon(Icons.arrow_back, size: 20.dm),
      ),
    );
  }

  static Widget buildCustomTitleBar({required bool showBackButton, EdgeInsets? padding, String? title, Widget? optionWidget}) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
      child: Row(
        crossAxisAlignment: (showBackButton) ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          (showBackButton) ? Align(alignment: Alignment.centerLeft, child: buildBackButton()) : SizedBox.shrink(),
          Expanded(
            child: (title != null)
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 18.sp, color: ColorUtils().ActiveColor, fontWeight: FontWeightUtils.LightBold),
                      textAlign: TextAlign.start,
                    ),
                  )
                : SizedBox.shrink(),
          ),
          (optionWidget != null)
              ? Padding(
                  padding: EdgeInsets.only(right: 5.w),
                  child: optionWidget,
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }

  static Widget getTextFieldErrorHint(RxString errorValidation) {
    return (errorValidation.isNotEmpty)
        ? Padding(
            padding: EdgeInsets.only(top: 3.h),
            child: Text(
              errorValidation.value,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeightUtils.Light, color: ColorUtils().TextFieldErrorColor),
            ),
          )
        : SizedBox.shrink();
  }

  static Widget buildCustomAppBar(String title, {Color? textColor}) {
    return InkWell(
      onTap: () => Get.back(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildCustomCard(
            padding: EdgeInsets.all(8.dm),
            radius: 10.r,
            // color: ColorUtils().BackgroundOverlayColor,
            child: Icon(Icons.arrow_back, size: 20.dm),
          ),
          SizedBox(width: 10.w),
          Text(
            title,
            style: TextStyle(fontSize: 18.sp, color: textColor, fontWeight: FontWeightUtils.LightBold),
          ),
        ],
      ),
    );
  }

  static Widget buildAuthAppBar({required bool showBackButton, EdgeInsets? padding, String? title, Widget? optionWidget}) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
      child: Row(
        crossAxisAlignment: (showBackButton) ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          (showBackButton) ? Align(alignment: Alignment.centerLeft, child: buildBackButton()) : SizedBox.shrink(),
          Expanded(
            child: (title != null)
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 18.sp, color: ColorUtils().ActiveColor, fontWeight: FontWeightUtils.LightBold),
                      textAlign: TextAlign.start,
                    ),
                  )
                : SizedBox.shrink(),
          ),
          (optionWidget != null)
              ? Padding(
                  padding: EdgeInsets.only(right: 5.w),
                  child: optionWidget,
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }

  static CircleLocalFileImage({required File imageFile, double? width, double? height, BoxFit? fit}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(image: FileImage(imageFile), fit: fit),
      ),
    );
  }

  static CircleAssetImage({required String imageAsset, double? width, double? height, BoxFit? fit}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(image: AssetImage(imageAsset), fit: fit),
      ),
    );
  }

  static CircleCachedNetworkImage({required String imageUrl, double? width, EdgeInsets? padding, double? height, BoxFit? fit}) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => Container(
        width: 45.w,
        height: 45.h,
        decoration: BoxDecoration(shape: BoxShape.circle, color: ColorUtils.GraySlightColor),
        padding: padding ?? EdgeInsets.symmetric(horizontal: 12.w),
        child: Shimmer.fromColors(baseColor: ColorUtils.PrimaryLightColor, highlightColor: ColorUtils.PrimaryColor, child: Image.asset("assets/facilitated_empire_logo.png")),
      ),
      errorWidget: (context, url, error) => Container(
        width: 45.w,
        height: 45.h,
        decoration: BoxDecoration(shape: BoxShape.circle, color: ColorUtils.GraySlightColor),
        padding: padding ?? EdgeInsets.symmetric(horizontal: 12.w),
        child: Image.asset("assets/facilitated_empire_logo.png", color: ColorUtils.PrimaryColor),
      ),
      imageBuilder: (context, imageProvider) => Container(
        width: 45.w,
        height: 45.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
    );
  }

  static Widget RoundedSquareCachedNetworkImage({required String imageUrl, double? width, double? height, double? radius, BoxFit? fit}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6.r),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) => Container(
          width: 45.w,
          height: 45.h,
          decoration: BoxDecoration(shape: BoxShape.rectangle, color: ColorUtils.GraySlightColor),
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Shimmer.fromColors(baseColor: ColorUtils.PrimaryLightColor, highlightColor: ColorUtils.PrimaryColor, child: Image.asset("assets/facilitated_empire_logo.png")),
        ),
        errorWidget: (context, url, error) => Container(
          width: 45.w,
          height: 45.h,
          decoration: BoxDecoration(shape: BoxShape.rectangle, color: ColorUtils.GraySlightColor),
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Image.asset("assets/facilitated_empire_logo.png", color: ColorUtils.PrimaryColor),
        ),
        imageBuilder: (context, imageProvider) => Container(
          width: 45.w,
          height: 45.h,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(radius ?? 6.r),
            image: DecorationImage(image: imageProvider, fit: fit ?? BoxFit.cover),
          ),
        ),
      ),
    );
  }

  static CustomCachedNetworkImage({required String imageUrl, double? width, double? height, BoxFit? fit}) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => Container(
        width: 45.w,
        height: 45.h,
        decoration: BoxDecoration(shape: BoxShape.rectangle, color: ColorUtils.GraySlightColor),
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Shimmer.fromColors(baseColor: ColorUtils.PrimaryLightColor, highlightColor: ColorUtils.PrimaryColor, child: Image.asset("assets/facilitated_empire_logo.png")),
      ),
      errorWidget: (context, url, error) => Container(
        width: 45.w,
        height: 45.h,
        decoration: BoxDecoration(shape: BoxShape.rectangle, color: ColorUtils.GraySlightColor),
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Image.asset("assets/facilitated_empire_logo.png", color: ColorUtils.PrimaryColor),
      ),
      imageBuilder: (context, imageProvider) => Container(
        width: 45.w,
        height: 45.h,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(0.r),
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
    );
  }

  static Widget buildPrimaryButton(BuildContext context, String title, Function() onClick) {
    return InkWell(
      onTap: ()=> onClick(),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 20.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(color: ColorUtils.PrimaryColor, borderRadius: BorderRadius.circular(99.r)),
        child: Text(
          title,
          style: TextStyle(fontSize: 18.sp, color: ColorUtils.WhiteColor, fontWeight: FontWeightUtils.LightBold),
        ),
      ),
    );
  }

  static Widget buildCustomOutlineButton({
    required BuildContext context,
    required Color outlineColor,
    Color? backgroundColor,
    required double radius,
    EdgeInsetsGeometry? padding,
    required Widget child,
    required Function() onClick,
  }) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        onClick();
      },
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: outlineColor, width: 1.2, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(radius),
        ),
        padding: (padding != null) ? padding : EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
        child: Center(child: child),
      ),
    );
  }

  static Widget buildCustomButton({
    required BuildContext context,
    bool? center,
    required Color backgroundColor,
    EdgeInsetsGeometry? padding,
    required Widget child,
    required double radius,
    required Function() onClick,
  }) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        onClick();
      },
      child: Container(
        decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(radius)),
        padding: (padding != null) ? padding : EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
        child: (center == true) ? Center(child: child) : child,
      ),
    );
  }

  static Widget buildCustomScaffold({
    bool? resizeToAvoidBottomInset,
    EdgeInsets? padding,
    CrossAxisAlignment? crossAxisAlignment,
    required List<Widget> children,
    FloatingActionButtonLocation? floatingActionButtonLocation,
    Widget? floatingActionButton,
  }) {
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: SafeArea(
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: Column(crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start, children: children),
        ),
      ),
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButton: floatingActionButton,
    );
  }

  static Widget buildDisallowIndicator({required Widget child}) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowIndicator();
        return true;
      },
      child: child,
    );
  }

  static Widget buildCustomSingleChildScrollView({ScrollPhysics? physics, ScrollController? scrollController, EdgeInsets? padding, Axis? scrollDirection, required Widget child}) {
    return buildDisallowIndicator(
      child: SingleChildScrollView(physics: physics, controller: scrollController, padding: padding, scrollDirection: scrollDirection ?? Axis.vertical, child: child),
    );
  }

  static Widget buildCustomRefreshIndicator({required Future<void> Function() onRefresh, required Widget child}) {
    return RefreshIndicator(
      onRefresh: () async {
        return onRefresh();
      },
      color: ColorUtils.PrimaryColor,
      child: child,
    );
  }

  static Widget buildCustomCard({Color? color, BorderSide? side, required EdgeInsets padding, EdgeInsets? margin, required double radius, double? elevation, Clip? clipBehavior, required child}) {
    return Card(
      shape: RoundedRectangleBorder(side: side ?? BorderSide.none, borderRadius: BorderRadius.circular(radius)),
      color: color ?? ColorUtils().CardBackgroundColor,
      margin: margin,
      elevation: (elevation ?? 1),
      clipBehavior: clipBehavior,
      child: Padding(padding: padding, child: child),
    );
  }

  static Widget buildCustomOutlineCard({
    Color? color,
    Color? outlineColor,
    required bool maxWidth,
    required EdgeInsets padding,
    EdgeInsets? margin,
    required double radius,
    double? elevation,
    required child,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: outlineColor ?? ColorUtils.PrimaryLightColor, width: 1),
        borderRadius: BorderRadius.circular(radius),
      ),
      color: color ?? const Color(0x00000000),
      margin: margin,
      elevation: (elevation ?? 1),
      child: Container(width: (maxWidth) ? double.infinity : null, padding: padding, child: child),
    );
  }

  static Widget buildSquareIcon(double padding, Color backgroundColor, Widget icon) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r), color: backgroundColor),
      child: icon,
    );
  }

  static Widget buildCircleIcon(double padding, Color backgroundColor, Widget icon) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(360.r), color: backgroundColor),
      child: icon,
    );
  }

  // static buildHtmlTextView(BaseViewModel viewModel, String content) {
  //   return HtmlWidget(content, textStyle: TextStyle(fontSize: 16.sp, color: ColorUtils().ActiveColor, fontWeight: FontWeightUtils.Regular), onTapUrl: (link) {
  //     return CommonUtils.openWebBrowserCustomTab(link);
  //   });
  // }

  static Widget getTextFieldTitle(String? title) {
    return (title != null)
        ? Padding(
            padding: EdgeInsets.only(bottom: 5.h),
            child: Text(
              title,
              style: TextStyle(fontSize: 14.sp, color: ColorUtils().TextFieldTitleColor, fontWeight: FontWeightUtils.Regular),
            ),
          )
        : SizedBox.shrink();
  }

  // static Widget buildPaginatedContainerCustomScrollView({required BaseViewModel viewModel, required Future<void> Function() onRefresh, required Function() loadMore, required Widget appbar, required Widget child}) {
  //   return LazyLoadScrollView(
  //       scrollOffset: 700,
  //       onEndOfPage: () => loadMore(),
  //       child: CommonViewUtils.buildCustomRefreshIndicator(
  //           onRefresh: () => onRefresh(),
  //           child: CustomScrollView(physics: AlwaysScrollableScrollPhysics(), slivers: [
  //             appbar,
  //             SliverToBoxAdapter(child: child),
  //             SliverToBoxAdapter(
  //                 child: (viewModel.loadMoreRunningProgressListener.value)
  //                     ? Padding(
  //                         padding: EdgeInsets.only(top: 10, bottom: 40),
  //                         child: Center(child: SpinKitPulse(color: ColorUtils.PrimaryColor, size: 30.dm)),
  //                       )
  //                     : SizedBox.shrink())
  //           ])));
  // }

  static Widget buildTextFieldTitle(String? title, String? subtitle) {
    return (title != null || subtitle != null)
        ? Padding(
            padding: EdgeInsets.only(bottom: 7.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (title != null)
                    ? Text(
                        title,
                        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeightUtils.LightBold),
                      )
                    : SizedBox.shrink(),
                (subtitle != null)
                    ? Text(
                        subtitle,
                        style: TextStyle(fontSize: 13.sp, color: ColorUtils().TextFieldHintColor, fontWeight: FontWeightUtils.Regular),
                      )
                    : SizedBox.shrink(),
              ],
            ),
          )
        : SizedBox.shrink();
  }

  static Widget buildTextFieldErrorHint(RxString errorValidation) {
    return (errorValidation.isNotEmpty)
        ? Padding(
            padding: EdgeInsets.only(top: 2),
            child: Text(
              errorValidation.value,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeightUtils.Light, color: ColorUtils().TextFieldErrorColor),
            ),
          )
        : SizedBox.shrink();
  }
}
