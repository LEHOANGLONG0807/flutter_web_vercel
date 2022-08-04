import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller.dart';
import 'package:app_visitor/common/common.dart';

class SplashScreen extends GetResponsiveView<SplashController> {
  SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'img_logo_company'.assetImagesPathPNG,
          width: 500,
        ),
      ),
    );
  }
}
