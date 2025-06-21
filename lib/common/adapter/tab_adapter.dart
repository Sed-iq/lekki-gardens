import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:LekkiGardens/common/model/tab_model.dart';

import '../../utils/color_utils.dart';
import '../../utils/font_weight_utils.dart';

class TabAdapter extends StatelessWidget {
  final int index;
  final int length;
  final int selectedTabIndex;
  final TabModel tabModel;
  final Function(TabModel) onItemClickListener;

  TabAdapter({required this.index, required this.length, required this.selectedTabIndex, required this.tabModel, required this.onItemClickListener});

  @override
  Widget build(BuildContext context) {
    EdgeInsets edgeInsetsMargin = EdgeInsets.symmetric(horizontal: 10.w);
    if (index == 0) {
      edgeInsetsMargin = EdgeInsets.only(left: 0, right: 20.w);
    } else if (index == length - 1) {
      edgeInsetsMargin = EdgeInsets.only(left: 20.w, right: 0);
    }
    return Padding(
      padding: edgeInsetsMargin,
      child: InkWell(
          splashFactory: NoSplash.splashFactory,
          onTap: () {
            onItemClickListener(tabModel);
          },
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
            Text(tabModel.title, style: TextStyle(fontSize: 15, color: (index == selectedTabIndex) ? ColorUtils().ActiveColor : ColorUtils().InActiveColor, fontWeight: (index == selectedTabIndex) ? FontWeightUtils.Bold : FontWeightUtils.Regular)),
            // SizedBox(height: 8),
            // (index == selectedTabIndex) ? SizedBox(width: 12.w * tabModel.title.length, child: Divider(color: ColorUtils().ActiveColor, thickness: 2.5, height: 0)) : SizedBox.shrink()
          ])),
    );
  }
}
