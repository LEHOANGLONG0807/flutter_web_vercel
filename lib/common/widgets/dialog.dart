import 'dart:math';

import 'package:app_form/common/common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/theme.dart';

class DialogQuestion extends StatelessWidget {
  final String messages;
  final String title;
  final String? titleBt1;
  final String? titleBt2;
  final VoidCallback? onTapButton1;
  final VoidCallback? onTapButton2;

  DialogQuestion(
      {Key? key,
      required this.messages,
      required this.title,
      this.titleBt1,
      this.titleBt2,
      this.onTapButton1,
      this.onTapButton2})
      : super(key: key);

  final _textTheme = Get.textTheme;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          width: min(Get.width,400),
          margin: const EdgeInsets.symmetric(horizontal: 35),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: _textTheme.headline5!.bold),
              20.verticalSpace,
              Text(
                messages,
                style: _textTheme.subtitle1,
                textAlign: TextAlign.center,
              ),
              25.verticalSpace,
              Row(
                children: [
                  Expanded(
                      child: Text(titleBt1 ?? 'Cancel')
                          .outlinedButton(
                              onPressed: onTapButton1 ?? Get.back, color: AppColors.colorGreyBBBBBB)
                          .wrapSize(45, 150)),
                  20.horizontalSpace,
                  Expanded(
                      child: Text(titleBt2 ?? 'OK')
                          .elevatedButton(onPressed: onTapButton2 ?? Get.back)
                          .wrapSize(45, 150)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
