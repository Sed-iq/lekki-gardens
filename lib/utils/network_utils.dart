import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkUtils{

  static Future<void> initDataRequest({Function()? dbCallback, Function()? networkCallback}) async {
    if(dbCallback != null){
      dbCallback();
    }
    if (await isNetworkConnected() && networkCallback != null) {
      networkCallback();
    }
  }

  static Future<bool> isNetworkConnected() async{
    List<ConnectivityResult> connectivityResultDataList =  await Connectivity().checkConnectivity();
    return connectivityResultDataList.any((connectivityResult) => connectivityResult == ConnectivityResult.wifi || connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.ethernet || connectivityResult == ConnectivityResult.other);
  }

}