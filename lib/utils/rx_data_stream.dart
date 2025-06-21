import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import '../base/base_view_model.dart';
import 'package:logger/logger.dart';
import '../common/model/network_error_model.dart';
import 'common_utils.dart';
import 'display_utils.dart';
import 'network_error_utils.dart';
import 'network_utils.dart';

class RxDataStream{

  static Future<void> sendNetworkRequest<T>({required BuildContext context, required BaseViewModel viewModel, required bool enableNetworkLoading, Function()? networkConnectedCallback, required Stream<T> Function() stream, bool? showErrorSnackBar, Function(dynamic, dynamic)? handleError, Function(T)? listen}) async{
    if (await NetworkUtils.isNetworkConnected()) {
      if(enableNetworkLoading){
        viewModel.setNetworkLoading();
      }
      if(networkConnectedCallback != null){
        networkConnectedCallback();
      }
      return await stream().handleError((error, stacktrace) {
        if(enableNetworkLoading){
          viewModel.isNetworkLoading.value = false;
        }
        if(kDebugMode){
          Logger(printer: PrettyPrinter()).f("Network error", error: error, stackTrace: stacktrace);
        }
        if(handleError != null){
          handleError(error, stacktrace);
        }
        var dioError = error as DioException;
        if((showErrorSnackBar ?? true)){
          viewModel.networkErrorListener.value = NetworkErrorModel(className: CommonUtils.getClassName(viewModel.runtimeType), errorMessage: NetworkErrorUtils.parseNetworkError(dioError));
        }
      }).listen((type) {
        if(enableNetworkLoading){
          viewModel.isNetworkLoading.value = false;
        }
        if(listen != null){
          listen(type);
        }
      }).asFuture();
    }else{
      DisplayUtils.showNoInternetSnackbar(context);
    }
  }

  static Future<void> getNetworkRequest<T>({required BaseViewModel viewModel, required bool enableNetworkLoading, String? apiNetworkCacheName, required Stream<T> Function() stream, bool? showErrorSnackBar, Function(dynamic, dynamic)? handleError, Function(T)? listen}) async{
    if(enableNetworkLoading){
      viewModel.setNetworkLoading();
    }
    return await stream().flatMap((value) {
      if(apiNetworkCacheName != null){
        return Stream.value(viewModel.getDataManager().saveApiNetworkCache(apiNetworkCacheName, (value != null) ? jsonEncode(value) : null)).map((_) => value);
      }else {
        return Stream.value(value);
      }
    }).handleError((error, stacktrace) {
      viewModel.isNetworkLoading.value = false;
      if(kDebugMode){
        Logger(printer: PrettyPrinter()).f("Network error", error: error, stackTrace: stacktrace);
      }
      if(handleError != null){
        handleError(error, stacktrace);
      }
      var dioError = error as DioException;
      if((showErrorSnackBar ?? true)){
        viewModel.networkErrorListener.value = NetworkErrorModel(className: CommonUtils.getClassName(viewModel.runtimeType), errorMessage: NetworkErrorUtils.parseNetworkError(dioError));
      }
    }).listen((type) {
      viewModel.isNetworkLoading.value = false;
      if(listen != null){
        listen(type);
      }
    }).asFuture();
  }

  static void getApiNetworkCache<T>({required BaseViewModel viewModel, required String apiNetworkCacheName, required T Function(String) dataModel, required Function(T?) listen}) {
    viewModel.getDataManager().getApiNetworkCache(apiNetworkCacheName).flatMap((apiNetworkCache) {
      if (apiNetworkCache != null) {
        return Stream.value(dataModel(apiNetworkCache));
      } else {
        return Stream.value(null);
      }
    }).listen((type) {
      viewModel.isNetworkLoading.value = false;
      listen(type);
    });
  }

  static List<T> getApiNetworkCacheDataList<T>({required String apiNetworkCache, required T Function(dynamic) dataModel}){
    Iterable iterable = json.decode(apiNetworkCache);
    return List<T>.from(iterable.map((model)=> dataModel(model)));
  }

}