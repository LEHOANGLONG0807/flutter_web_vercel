import 'dart:math';

import 'package:flutter/material.dart';
import 'package:app_form/common/common.dart';
import 'package:get/get.dart';

class ViewCheckoutSuccess extends StatelessWidget {
  ViewCheckoutSuccess({Key? key}) : super(key: key);

  final _textTheme = Get.textTheme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              10.verticalSpace,
              Image.asset(
                'img_logo_company'.assetImagesPathPNG,
                height: 30,
              ),
              58.verticalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Excellent! Thanks for visiting HTH.',
                    style: _textTheme.headline3!.textPrimary,
                  ),
                  Row(),
                  12.verticalSpace,
                  Text(
                    'You have checked out successfully.\nHope to see you back.',
                    style: _textTheme.headline5!.semiBold.textGrey797979,
                  ),
                ],
              ),
              80.verticalSpace,
              Image.asset('img_checkout_success'.assetImagesPathPNG,width: Get.width/2,),
              80.verticalSpace,
              const Text('Sure').elevatedButton(onPressed: Get.back).wrapWidth(300),
              18.verticalSpace,
            ],
          ).wrapWidth(min(Get.width, 500)).paddingSymmetric(horizontal: 22),
        ),
      ),
    );
  }
}
