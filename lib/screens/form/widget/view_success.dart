import 'package:flutter/material.dart';
import 'package:app_form/common/common.dart';
import 'package:get/get.dart';

import '../controller.dart';

class ViewSubmitSuccess extends GetView<FormController> {
  ViewSubmitSuccess({Key? key}) : super(key: key);

  final _textTheme = Get.textTheme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            50.verticalSpace,
            Image.asset(
              'img_logo_company'.assetImagesPathPNG,
              height: 100,
            ),
            40.verticalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CONGRATULATIONS!',
                  style: _textTheme.headline3!.textPrimary,
                ),
                Row(),
                12.verticalSpace,
                RichText(
                  text: TextSpan(
                      text: 'You have checked in successfully.\nYour ID is ',
                      style: _textTheme.headline5!.semiBold.textGrey797979,
                      children: [
                        TextSpan(
                          text: '${controller.idCreateCustomer}.',
                          style: _textTheme.headline5!.textPrimary.medium,
                        ),
                      ]),
                ),
              ],
            ),
            40.verticalSpace,
            Expanded(
                child:
                    Image.asset('img_success'.assetImagesPathPNG).paddingSymmetric(horizontal: 30)),
            80.verticalSpace,
            const Text('Done').elevatedButton(onPressed: Get.back).wrapWidth(300),
            // 30.verticalSpace,
            // InkWell(
            //   onTap: Get.back,
            //   child: Text(
            //     'Cancel',
            //     style: _textTheme.headline5!.textGrey797979.regular,
            //   ),
            // ),
            150.verticalSpace,
          ],
        ).paddingSymmetric(horizontal: 100),
      ),
    );
  }
}
