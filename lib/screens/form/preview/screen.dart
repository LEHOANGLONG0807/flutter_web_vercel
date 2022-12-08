import 'package:app_visitor/models/models.dart';
import 'package:app_visitor/theme/asset_colors.dart';

import 'controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_visitor/common/common.dart';

class PreviewCheckInScreen extends GetView<PreviewCheckInController> {
  PreviewCheckInScreen({Key? key}) : super(key: key);

  final _textTheme = Get.textTheme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            60.verticalSpace,
            Image.asset(
              'img_logo_company'.assetImagesPathPNG,
              height: 60,
            ),
            60.verticalSpace,
            Text(
              'Get Started',
              style: _textTheme.headline4!.regular,
            ),
            20.verticalSpace,
            Expanded(
              child: PageView(
                controller: controller.pageController,
                children: controller.models.map((e) {
                  return _buildItem(e);
                }).toList(),
              ),
            ),
            _buildRowIndicator(),
            35.verticalSpace,
            InkWell(
              onTap: Get.back,
              child: Text(
                'Back to Home',
                style: _textTheme.headline5!.textPrimary.regular,
              ),
            ),
            (Get.height / 15).verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget _buildRowIndicator() {
    return Obx(() {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: controller.models
            .asMap()
            .keys
            .map((index) => _buildItemDot(
                  index: index,
                  isFocus: controller.currentIndex.value == index,
                  onTap: () => controller.onTapNext(index),
                ).paddingSymmetric(horizontal: 8))
            .toList(),
      );
    });
  }

  Widget _buildItemDot({required int index, bool isFocus = false, VoidCallback? onTap}) {
    if (isFocus == false) {
      return Container(
        width: 25,
        height: 25,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.colorGreyE8E8E8,
        ),
      );
    }
    if (index < 2) {
      return Image.asset('ic_arrow_right'.assetImagesPathPNG)
          .paddingAll(15)
          .elevatedButton(onPressed: onTap)
          .wrapSize(75, 76);
    }
    return const Text('Start').elevatedButton(onPressed: onTap).wrapSize(75, 160);
  }

  Widget _buildItem(PreviewCheckInModel model) {
    if (Get.width >= 1000) {
      return Column(
        children: [
          20.verticalSpace,
          Image.asset(
            model.icon.assetImagesPathPNG,
            height: 120,
          ),
          25.verticalSpace,
          Text(
            model.title,
            style: _textTheme.headline3!.semiBold.textBlack.size(36),
          ),
          16.verticalSpace,
          Text(
            model.content,
            style: _textTheme.headline5!.textGrey797979.light.size(24).heightLine(40),
            textAlign: TextAlign.center,
          ),
        ],
      ).paddingSymmetric(horizontal: 200);
    }
    return Column(
      children: [
        80.verticalSpace,
        Image.asset(
          model.icon.assetImagesPathPNG,
          height: 180,
        ),
        30.verticalSpace,
        Text(
          model.title,
          style: _textTheme.headline3!.semiBold.textBlack.size(36),
        ),
        20.verticalSpace,
        Text(
          model.content,
          style: _textTheme.headline5!.textGrey797979.light.size(24).heightLine(45),
          textAlign: TextAlign.center,
        ),
      ],
    ).paddingSymmetric(horizontal: 120);
  }
}
