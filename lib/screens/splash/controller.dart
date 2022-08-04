import 'package:get/get.dart';

import '../../../routes/routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(2.seconds, () {
      if(GetPlatform.isWeb){
        Get.offAndToNamed(Routes.webManager);
      }else{
        Get.offAndToNamed(Routes.main);
      }
    });
  }
}
