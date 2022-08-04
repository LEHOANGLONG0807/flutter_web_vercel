
import 'package:app_visitor/models/models.dart';
import 'package:app_visitor/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_visitor/common/common.dart';
import 'controller.dart';

class MainScreen extends GetResponsiveView<MainController> {
  MainScreen({Key? key}) : super(key: key);

  final _textTheme = Get.textTheme;

  @override
  Widget phone() {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            60.verticalSpace,
            Image.asset(
              'img_logo_company'.assetImagesPathPNG,
              height: 60,
            ),
            30.verticalSpace,
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 50, left: 100, right: 100),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Welcome to HTH Communications',
                        style: _textTheme.headline3!.textPrimary,
                      ),
                      5.verticalSpace,
                      Text(
                        'Giving you products and services of the highest quality, at the most resonable prices!',
                        textAlign: TextAlign.center,
                        style: _textTheme.headline4!.textGrey797979.regular,
                      ),
                      90.verticalSpace,
                      ...controller.actions.map(
                        (e) => _buildItem(e).paddingOnly(bottom: 60),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(MainActionModel model) {
    return InkWell(
      onTap: () => controller.onTap(model.id),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            model.icon.assetImagesPathPNG,
            width: 60,
          ),
          20.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      model.title,
                      style: _textTheme.headline3!.textPrimary.size(30),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_right_rounded,
                      color: AppColors.primary,
                      size: 40,
                    ),
                  ],
                ),
                5.verticalSpace,
                Text(model.content, style: _textTheme.headline4!.textGrey797979.light),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
