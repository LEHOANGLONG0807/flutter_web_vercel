import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'biz/biz.dart';
import 'repository/repository.dart';
import 'routes/routes.dart';
import 'theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent),
    );

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    final initialBinding = BindingsBuilder(() {
      Get.put(AppService());
      // Get.put(FirebaseService());
      Get.lazyPut<IFirebaseRepository>(() => FirebaseRepository(), fenix: true);
      Get.put(AppController());
    });
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 500)
      ..errorWidget = const Icon(
        Icons.clear,
        color: Colors.red,
        size: 50,
      )
      ..successWidget = const Icon(
        Icons.done,
        color: Colors.green,
        size: 50,
      )
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..backgroundColor = Colors.transparent
      ..indicatorColor = AppColors.primary
      ..textColor = Colors.white
      ..maskType = EasyLoadingMaskType.black
      ..maskColor = AppColors.primary.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: AppPages.pages,
      theme: AirTalkThemeData.themeData,
      darkTheme: AirTalkThemeData.themeData,
      builder: EasyLoading.init(),
      initialBinding: initialBinding,
      defaultTransition: Transition.native,
      initialRoute: Routes.splash,
    );
  }
}
