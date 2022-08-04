import 'package:app_form/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../routes/routes.dart';

class PreviewCheckInController extends GetxController {
  final pageController = PageController();

  final currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    pageController.addListener(() {
      currentIndex.value = pageController.page?.round() ?? 0;
    });
  }

  void onTapNext(int index) {
    if (index == 2) {
      Get.offNamed(Routes.form);
    } else {
      pageController.animateToPage(index + 1, duration: 250.milliseconds, curve: Curves.linear);
    }
  }

  final models = [
    PreviewCheckInModel(
      icon: 'ic_camera',
      title: 'Security Notice',
      content:
          '''No camera, camera phones, PDA's, tablet or laptop computers, or portable drives are allowed into production areas unless prior
authorization by management.''',
    ),
    PreviewCheckInModel(
      icon: 'ic_safety',
      title: 'Safety Notice',
      content:
          '''When being escorted throughout the facility you are instructed to follow and adhere to all signs and warnings, including those communicated by your escort.''',
    ),
    PreviewCheckInModel(
      icon: 'ic_location',
      title: 'Environmental Notice',
      content:
          '''You are required to adhere to all warnings, signs, and instructions while on the premises. ''',
    ),
  ];
}
