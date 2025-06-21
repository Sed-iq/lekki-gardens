import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import '../common/model/network_error_model.dart';
import '../utils/color_utils.dart';
import '../utils/common_utils.dart';
import '../utils/display_utils.dart';
import '../utils/network_utils.dart';
import 'base_view_model.dart';

class BaseView<T extends BaseViewModel> extends StatefulWidget {
  final Function(T) onInit;
  final Function(T) onResumed;
  final Function(T) onPaused;
  final Function(T) onInternetConnected;
  final Function(T) onInternetDisconnected;
  final Function(T) onDispose;
  final Widget Function(BuildContext, T) view;
  bool isPreviouslyDisconnected = false;

  BaseView({Key? key, required this.onInit, required this.onResumed, required this.onPaused,  required this.onInternetConnected, required this.onInternetDisconnected, required this.onDispose, required this.view}) : super(key: key);

  @override
  _BaseViewState createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> with WidgetsBindingObserver {
  late StreamSubscription<List<ConnectivityResult> > connectivitySubscription;
  var getViewModel;


  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    getViewModel = Get.find<T>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      CommonUtils.getSystemUIOverlayStyle(context);
      getViewModel.getUserData();
      widget.onInit(getViewModel);
    });
    connectivitySubscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> connectivityResultDataList) {
      if(connectivityResultDataList.any((connectivityResult) => connectivityResult == ConnectivityResult.wifi || connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.ethernet || connectivityResult == ConnectivityResult.other)){
        if(widget.isPreviouslyDisconnected) {
          widget.onInternetConnected(getViewModel);
          getViewModel.setChatUser(true);
          DisplayUtils.showInternetSnackbar(context);
          setState(() {
            widget.isPreviouslyDisconnected = false;
          });
        }
      }else{
        setState(() {
          widget.isPreviouslyDisconnected = true;
        });
        widget.onInternetDisconnected(getViewModel);
        DisplayUtils.showNoInternetSnackbar(context);
      }
    });
    super.initState();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if(await NetworkUtils.isNetworkConnected() == true){
      if (state == AppLifecycleState.resumed) {

      } else if (state == AppLifecycleState.inactive) {

      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    widget.onDispose(getViewModel);
    connectivitySubscription.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GetX<T>(
          builder: (baseViewModel) {
            return DisplayUtils.showCustomLoading(
                isLoading: baseViewModel.isNetworkLoading.value,
                isFullScreen: true,
                context: context,
                progressPercent: baseViewModel.networkProgressPercent.value,
                child: FocusDetector(
                    onFocusLost: () {
                      widget.onPaused(getViewModel);
                      // getViewModel.setChatUser(false);
                    },
                    onFocusGained: () {
                      widget.onResumed(getViewModel);
                      // getViewModel.setChatUser(true);
                    },
                    child: (baseViewModel.getDataManager().getSaveLoginState()) ? (baseViewModel.userDataListener.value != null) ? widget.view(context, getViewModel) : Container(color: ColorUtils().BackgroundColor) : widget.view(context, getViewModel))
            );
          },
        ),
        GetX<T>(
          builder: (baseViewModel) {
            NetworkErrorModel? networkErrorModel = baseViewModel.networkErrorListener.value;
            if(networkErrorModel != null && CommonUtils.getClassName(getViewModel.runtimeType) == networkErrorModel.className){
              WidgetsBinding.instance.addPostFrameCallback((_){
                DisplayUtils.showCustomSnackbar(context, networkErrorModel.errorMessage, Icons.error_outline, ColorUtils.FlushbarErrorColor, ColorUtils.FlushbarTextColor, Duration(seconds: 4));
                getViewModel.resetNotifyListeners();
              });
            }
            return SizedBox.shrink();
          },
        )
      ],
    );
  }
}