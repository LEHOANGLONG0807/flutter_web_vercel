import 'package:app_form/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:app_form/common/common.dart';
import 'package:get/get.dart';

class BottomSheetConfirmCheckout extends StatelessWidget {
  const BottomSheetConfirmCheckout({Key? key, this.onTapSure, this.onTapCancel}) : super(key: key);

  final VoidCallback? onTapSure;
  final VoidCallback? onTapCancel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40),
          topLeft: Radius.circular(40),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: Get.back,
                child: const Icon(
                  Icons.close,
                  color: AppColors.colorGrey797979,
                  size: 18,
                ),
              ),
            ),
            Text(
              'Are you sure to check out?',
              style: Get.textTheme.headline5!.regular.textPrimary.size(22),
            ),
            30.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: const Text('Cancel').outlinedButton(
                    onPressed: () {
                      onTapCancel?.call();
                      Get.back();
                    },
                    color: AppColors.colorGreyBBBBBB,
                  ),
                ),
                10.horizontalSpace,
                Expanded(
                  child: const Text('Sure').elevatedButton(
                    onPressed: () {
                      Get.back();
                      onTapSure?.call();
                    },
                  ),
                ),
              ],
            )
          ],
        ).paddingOnly(left: 24, right: 24, top: 20, bottom: 25),
      ),
    );
  }
}
