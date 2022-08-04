import 'package:app_form/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:app_form/common/common.dart';
import 'package:get/get.dart';

class BottomSheetConfirmSubmit extends StatelessWidget {
  const BottomSheetConfirmSubmit({Key? key, this.onTapSure}) : super(key: key);

  final VoidCallback? onTapSure;

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
              'Are you sure to check in?',
              style: Get.textTheme.headline3!.regular.textPrimary,
            ),
            40.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: const Text('Back to edit').outlinedButton(
                    onPressed: Get.back,
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
            ),
            30.verticalSpace,
          ],
        ).paddingOnly(left: 100, right: 100, top: 20, bottom: 25),
      ),
    );
  }
}
