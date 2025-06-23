import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:LekkiGardens/routes.dart';
import 'package:LekkiGardens/utils/color_utils.dart';
import 'package:LekkiGardens/utils/common_utils.dart';
import 'package:LekkiGardens/utils/splash_screen_utils.dart';
import 'package:lehttp_overrides/lehttp_overrides.dart';

import 'data/api/api_helper.dart';
import 'data/api/app_api_helper.dart';
import 'data/api/env/env.dart';
import 'data/app_data_manager.dart';
import 'data/data_manager.dart';
import 'data/database/app_database_helper.dart';
import 'data/database/database_helper.dart';
import 'data/sharedPreference/app_shared_preference_helper.dart';
import 'data/sharedPreference/shared_preference_helper.dart';
import 'features/auth/signin/sign_in_view_model.dart';
import 'features/intro/onboarding/onboarding.dart';
import 'view_model_provider_factory.dart';

Future<void> main() async {
  final binding = WidgetsFlutterBinding.ensureInitialized();
  GestureBinding.instance?.resamplingEnabled = true;
  binding.deferFirstFrame();
  binding.addPostFrameCallback((_) async {
    BuildContext context = binding.rootElement as BuildContext;
    binding.allowFirstFrame();
  });
  SplashScreenUtils.preserve(widgetsBinding: binding);
  await GetStorage.init();
  if (GetPlatform.isAndroid) {
    HttpOverrides.global = LEHttpOverrides();
  }
  var dio = Dio(BaseOptions(sendTimeout: Duration(minutes: 5), connectTimeout: Duration(minutes: 5), receiveTimeout: Duration(minutes: 5)));
  dio.interceptors.add(InterceptorsWrapper(onRequest: (request, handler) async {
    request.headers["secret"] = Env.MVVMTEMPLATE_REMOTE_BASEURL;
    String loginToken = CommonUtils.getLoginToken();
    if (loginToken.isNotEmpty){
      request.headers["Authorization"] = "Bearer $loginToken";
    }
    return handler.next(request);
  }));
  if(kDebugMode){
    dio.interceptors.add(LogInterceptor(request: true, requestHeader: true, requestBody: true, responseHeader: true, responseBody: true, error: true));
  }
  GetStorage getStorage = GetStorage();
  Get.put(getStorage);
  Get.put(AppApiHelper(dio) as ApiHelper);
  Get.put(AppSharedPreferenceHelper(Get.find()) as SharedPreferenceHelper);
  Get.put(AppDatabaseHelper(Get.find()) as DatabaseHelper);
  Get.put(AppDataManager(Get.find(), Get.find(), Get.find()) as DataManager);
  runApp(MyApp(SignInViewModel().getInitialRoute(), SignInViewModel().isDarkMode()));
}

class MyApp extends StatefulWidget {
  final String initialRoute;
  final bool isDarkMode;

  MyApp(this.initialRoute, this.isDarkMode);

  @override
  State<MyApp> createState() => _MyAppState(initialRoute, isDarkMode);
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final String initialRoute;
  final bool isDarkMode;
  late bool isLocked;

  _MyAppState(this.initialRoute, this.isDarkMode);


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if(state == AppLifecycleState.inactive){
      CommonUtils.getSystemUIOverlayStyle(context);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    CommonUtils.getSystemUIOverlayStyle(context);
    ThemeData lightThemeData = ThemeData(
        appBarTheme: AppBarTheme(color: Color(0xFFFFFFFF), surfaceTintColor: Color(0xFFFFFFFF), titleTextStyle: TextStyle(color: ColorUtils.BlackColor), iconTheme: IconThemeData(color: ColorUtils.BlackColor)),
        brightness: Brightness.light,
        primaryColor: ColorUtils.PrimaryColor,
        scaffoldBackgroundColor: Color(0xFFF0F0F0),
        fontFamily: "Outfit",
        fontFamilyFallback: ["Sans-Serif"],
        cardTheme: CardThemeData(elevation: 3, color: Color(0xFFFFFFFF), surfaceTintColor: Color(0xFFFFFFFF), shadowColor: Color(0x4F000000)),
        inputDecorationTheme: InputDecorationTheme(
            contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: new BorderSide(color: Colors.transparent, width: 1.3), gapPadding: 0),
            disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: new BorderSide(color: Colors.transparent, width: 1.3), gapPadding: 0),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: new BorderSide(color: Color(0xFF2D77FC), width: 1.3), gapPadding: 0),
            border: OutlineInputBorder(),
            fillColor: Color(0xFFF2F2F2),
            hintStyle: TextStyle(color: Color(0xFF757575)),
            labelStyle: TextStyle(color: Color(0xFF616161)),
            filled: true),
        dividerTheme: DividerThemeData(color: Color.fromRGBO(20, 20, 28, 1)),
        unselectedWidgetColor: Color(0xFFA9A9A9),
        textSelectionTheme: TextSelectionThemeData(cursorColor: Color(0xFF2C3131), selectionHandleColor: Color(0xFF2C3131))
    );


    ThemeData darkThemeData = ThemeData(
        appBarTheme: AppBarTheme(color: Color(0xFF010E0E), surfaceTintColor: Color(0xFF010E0E), titleTextStyle: TextStyle(color: ColorUtils.WhiteColor), iconTheme: IconThemeData(color: ColorUtils.WhiteColor)),
        brightness: Brightness.dark,
        primaryColor: ColorUtils.PrimaryColor,
        scaffoldBackgroundColor: Color(0xFF010E0E),
        fontFamily: "Outfit",
        fontFamilyFallback: ["Sans-Serif"],
        cardTheme: CardThemeData(elevation: 3, color: Color(0xFF282828), surfaceTintColor: Color(0xFF282828), shadowColor: Color(0x4F000000)),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: new BorderSide(color: Colors.transparent, width: 1.3), gapPadding: 0),
          disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: new BorderSide(color: Colors.transparent, width: 1.3), gapPadding: 0),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: new BorderSide(color: Color(0xFFE4E4E4), width: 1.3), gapPadding: 0),
          border: OutlineInputBorder(),
          fillColor: Color(0xFF424242),
          hintStyle: TextStyle(color: Color(0xFFE4E4E4)),
          labelStyle: TextStyle(color: Color(0xFFE4E4E4)),
          filled: true,
        ),
        dividerTheme: DividerThemeData(color: Color.fromRGBO(20, 20, 28, 1)),
        unselectedWidgetColor: Color(0xFFA2A5A2),
        textSelectionTheme: TextSelectionThemeData(cursorColor: Color(0xFFFFFFFF), selectionHandleColor: Color(0xFFFFFFFF))
    );
    Timer(Duration(seconds: 2), () {SplashScreenUtils.remove();});
    return ScreenUtilInit(
      designSize: Size(428, 959),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context , child) {
        return KeyboardDismisser(
          gestures: [GestureType.onTap, GestureType.onPanUpdateDownDirection, GestureType.onPanUpdateUpDirection],
          child: GetMaterialApp(
              navigatorKey: Get.key,
              title: "Facilitated Empire",
              debugShowCheckedModeBanner: false,
              themeMode: (!isDarkMode) ? ThemeMode.light : ThemeMode.dark,
              theme: lightThemeData,
              darkTheme: darkThemeData,
              initialBinding: ViewModelProviderFactory(),
              initialRoute: initialRoute,
              getPages: Routes.pageRouteDataList
          ),
        );
      },
    );
  }
}