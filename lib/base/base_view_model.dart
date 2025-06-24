import 'package:LekkiGardens/common/model/bottom_sheet_picker_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../common/model/network_error_model.dart';
import '../data/data_manager.dart';
import '../features/auth/model/user_response_model.dart';

class BaseViewModel<T> extends GetxController {
  DataManager getDataManager() {
    return Get.find();
  }

  Rxn<UserDataModel> userDataListener = Rxn<UserDataModel>();
  RxBool isNetworkLoading = false.obs;
  RxBool hasUserLogin = false.obs;
  RxBool isBottomSheetNetworkLoading = false.obs;
  RxInt customTabIndexListener = 0.obs;
  Rxn<int> networkProgressPercent = Rxn<int>();
  Rxn<NetworkErrorModel> networkErrorListener = Rxn<NetworkErrorModel>();
  RxBool passwordHiddenToggle = true.obs;
  DateTime? timerCountDownListener;
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController otpCodeController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  RxString emailValidation = "".obs;
  RxString passwordValidation = "".obs;
  Rxn<BottomSheetPickerModel> bottomSheetPickerListener = Rxn<BottomSheetPickerModel>();
  RxString currencyValidation = "".obs;
  RxString bottomSheetPickerValidation = "".obs;
  RxString fullnameValidation = "".obs;
  RxString phoneNumberValidation = "".obs;
  RxString firstNameValidation = "".obs;
  RxString lastNameValidation = "".obs;
  RxString genericTextFieldValidation = "".obs;
  RxString OTPValidation = "".obs;

  void setUserLogin(bool state) {
    hasUserLogin.value = state;
    getDataManager().saveLoginState(state);
  }

  void getUserData() {
    userDataListener.value = getDataManager().getLoginUser();
  }

  void setNetworkLoading() {
    this.isNetworkLoading.value = true;
  }

  void setCustomTabIndex(int customTabIndex) {
    this.customTabIndexListener.value = customTabIndex;
    update();
  }

  void setBottomSheetNetworkLoading() {
    this.isBottomSheetNetworkLoading.value = true;
  }

  void setNetworkProgressPercent(int? progressPercent) {
    this.networkProgressPercent.value = progressPercent;
  }

  void setPasswordHiddenToggle(bool passwordHiddenToggle) {
    this.passwordHiddenToggle.value = passwordHiddenToggle;
  }

  void setBottomSheetPicker(BottomSheetPickerModel? bottomSheetPickerModel) {
    bottomSheetPickerListener.value = bottomSheetPickerModel;
  }

  void startTimerCountDown(Duration duration) {
    timerCountDownListener = DateTime.now().add(duration);
    update();
  }

  void resetTimerCountDownListener() {
    if (timerCountDownListener != null) {
      timerCountDownListener = null;
    }
    update();
  }

  void resetNotifyListeners() {
    if (networkErrorListener.value != null) {
      networkErrorListener.value = null;
    }
    if (emailValidation.isNotEmpty) {
      emailValidation.value = "";
    }
    if (passwordValidation.isNotEmpty) {
      passwordValidation.value = "";
    }
    if (fullnameValidation.isNotEmpty) {
      fullnameValidation.value = "";
    }
    if (phoneNumberValidation.isNotEmpty) {
      phoneNumberValidation.value = "";
    }
    if (genericTextFieldValidation.isNotEmpty) {
      genericTextFieldValidation.value = "";
    }
    if (OTPValidation.isNotEmpty) {
      OTPValidation.value = "";
    }
    if (currencyValidation.isNotEmpty) {
      currencyValidation.value = "";
    }
    if (firstNameValidation.isNotEmpty) {
      firstNameValidation.value = "";
    }
    if (lastNameValidation.isNotEmpty) {
      lastNameValidation.value = "";
    }
    if (bottomSheetPickerValidation.isNotEmpty) {
      bottomSheetPickerValidation.value = "";
    }
  }
}
