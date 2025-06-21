import 'package:dio/dio.dart';
import '../common/model/api_response_model.dart';


class NetworkErrorUtils{
  static String parseNetworkError(DioException dioError){
    var errorMessage;
    if(dioError.type == DioExceptionType.badResponse){
      ApiResponseModel apiResponseModel = ApiResponseModel.fromJson(dioError.response!.data);
      errorMessage = apiResponseModel.message;
      if(apiResponseModel.message == "User not Authenticated, Please Login"){
        //  Get.find<DashboardViewModel>().logOut();
      }
    }else{
      errorMessage = "Your internet connection is not stable, please try again";
    }
    return errorMessage;
  }
}