import 'package:app_form/models/models.dart';
import 'package:get/get.dart';

import '../../routes/routes.dart';

class MainController extends GetxController {
  final actions = [
    MainActionModel(
        icon: 'ic_form',
        id: 1,
        title: 'Check-in',
        content:
            'Welcome aboard! We look forward to helping you get the most out of HTH. Just check in and enjoy the visit. '),
    MainActionModel(
        icon: 'ic_checkout',
        id: 2,
        title: 'Check-out',
        content:
            'Please check out to finish the visit. Having a visitor like you is truly a blessing for HTH. '),
    MainActionModel(
        icon: 'ic_list',
        id: 3,
        title: 'List',
        content: 'We have welcomed many visitors today. You can explore HTH Community here.'),
  ];

  void onTap(int id) {
    switch (id) {
      case 3:
        Get.toNamed(Routes.listForm);
        break;
      case 1:
        Get.toNamed(Routes.previewCheckIn);
        break;
      case 2:
        Get.toNamed(Routes.scanQR);
        break;
    }
  }
}
