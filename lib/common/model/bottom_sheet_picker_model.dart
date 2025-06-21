import '../../utils/enum_data_utils.dart';


class BottomSheetPickerModel {
  final ImageType? imageType;
  final String? image;
  final String title;
  final String? subTitle;
  final String value;
  final dynamic subValue;
  final bool enabled;

  BottomSheetPickerModel({this.imageType, this.image, required this.title, this.subTitle, required this.value, this.subValue, required this.enabled});
}