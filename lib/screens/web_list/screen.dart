import 'package:app_visitor/models/models.dart';
import 'package:app_visitor/screens/web_list/controller.dart';
import 'package:app_visitor/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_visitor/common/common.dart';

class WebManagerScreen extends GetView<WebManagerController> {
  WebManagerScreen({Key? key}) : super(key: key);

  final _textTheme = Get.textTheme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff31438B),
      body: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.only(left: 100, right: 100, top: 20, bottom: 10),
            margin: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Image.asset(
                  'img_logo_company'.assetImagesPathPNG,
                  width: 120,
                ),
                15.verticalSpace,
                Obx(() {
                  return InkWell(
                    onTap: controller.onTapChangeDate,
                    child: Text(
                      controller.date.value.formatDateTime('MM/dd/yyyy'),
                      style: _textTheme.headline3!.textPrimary.letterSpaC(0.6),
                    ),
                  );
                },),
                25.verticalSpace,
                _buildHeader(),
                const Divider(),
                _buildData(),
              ],
            ),
          ),
          Image.asset(
            'ic_ghim'.assetImagesPathPNG,
            width: 50,
          ).paddingOnly(top: 10, right: 100)
        ],
      ),
    );
  }

  Widget _buildHeader() {
    Widget _item(String title) {
      return Text(
        title,
        style: _textTheme.bodyText2!.semiBold.textGreyBBBBBB,
      );
    }

    return Row(
      children: [
        Expanded(flex: 4, child: _item('CUSTOMER NAME')),
        Expanded(flex: 3, child: _item('COMPANY')),
        Expanded(flex: 3, child: _item('CHECK-IN')),
        Expanded(flex: 2, child: _item('ACTION')),
      ],
    );
  }

  Widget _buildData() {
    return Expanded(
      child: GetBuilder<WebManagerController>(
        builder: (_) {
          if (controller.customers.isEmpty) {
            return _buildNotFound();
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 20),
            itemBuilder: (_, index) {
              return _buildItemCustomer(controller.customers[index]);
            },
            separatorBuilder: (_, __) => 32.verticalSpace,
            itemCount: controller.customers.length,
          );
        },
      ),
    );
  }

  Widget _buildNotFound() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'ic_not_found'.assetImagesPathPNG,
          width: 200,
        ),
        40.verticalSpace,
        Text(
          'No Visitor Yet!',
          style: _textTheme.bodyText1!.textGreyBBBBBB,
        ),
        100.verticalSpace,
      ],
    );
  }

  Widget _buildItemCustomer(CustomerModel model) {
    Widget _item(String title) {
      return Text(
        title.trim(),
        style: _textTheme.bodyText2!.semiBold.textBlack,
      );
    }

    return Row(
      children: [
        Expanded(flex: 4, child: _item(model.displayName)),
        Expanded(flex: 3, child: _item(model.company)),
        Expanded(
            flex: 3, child: _item(model.timeIn.formatDateTime('hh:mm a MM/dd/yyyy').toUpperCase())),
        Expanded(
          flex: 2,
          child: InkWell(
            onTap: () => controller.onTapViewFile(model),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.visibility,
                  color: AppColors.primary,
                  size: 16,
                ),
                10.horizontalSpace,
                Text(
                  'View file',
                  style: _textTheme.bodyText2!.textPrimary.semiBold,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
