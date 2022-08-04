import 'dart:math';

import 'package:app_visitor/models/models.dart';
import 'controller.dart';
import 'package:app_visitor/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_visitor/common/common.dart';

class ListScreen extends GetView<ListController> {
  ListScreen({Key? key}) : super(key: key);

  final _textTheme = Get.textTheme;

  static final _inputBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.transparent),
    borderRadius: BorderRadius.circular(1000),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white,size: 40),
        title: Text(
          DateTime.now().formatDateddMMyyyy,
          style: _textTheme.headline6!.textWhite,
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('img_bg_list'.assetImagesPathPNG),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              10.verticalSpace,
              Obx(() {
                return Text(
                  'Today visitors: ${controller.totalVisitors}',
                  style: _textTheme.headline4!.textWhite,
                );
              }),
              25.verticalSpace,
              _buildTextSearch(),
              30.verticalSpace,
              _buildContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Expanded(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.only(left: 40, right: 40, top: 50),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Obx(() {
          if (controller.listCustomerObs.isEmpty) {
            return _buildNotFound();
          }
          if (Get.width > 600) {
            return Column(
              children: [
                if (controller.keySearchController.text.isNotEmpty) _buildTotalResultSearch(),
                Expanded(child: _buildGirdView()),
              ],
            );
          }
          return Column(
            children: [
              if (controller.keySearchController.text.isNotEmpty) _buildTotalResultSearch(),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  itemBuilder: (_, index) {
                    final model = controller.listCustomerObs[index];
                    return _buildItem(model);
                  },
                  separatorBuilder: (_, __) => const Divider(height: 30),
                  itemCount: controller.listCustomerObs.length,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildTextSearch() {
    return TextFormField(
      onChanged: controller.onSearch,
      controller: controller.keySearchController,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search, size: 24),
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        filled: true,
        border: _inputBorder,
        errorBorder: _inputBorder,
        focusedBorder: _inputBorder,
        enabledBorder: _inputBorder,
        disabledBorder: _inputBorder,
        hintText: 'Search name, company',
      ),
    ).wrapWidth(min(Get.width, 400)).paddingSymmetric(horizontal: 22);
  }

  Widget _buildTotalResultSearch() {
    return Row(
      children: [
        InkWell(
          onTap: controller.clearSearch,
          child: Image.asset('ic_close_result'.assetImagesPathPNG, width: 35),
        ),
        10.horizontalSpace,
        Expanded(
          child: Text(
            '${controller.listCustomerObs.length} results found',
            style: _textTheme.subtitle1!.semiBold.textPrimary,
          ),
        ),
      ],
    ).paddingOnly(bottom: 5);
  }

  Widget _buildGirdView() {
    return GridView.count(
      padding: const EdgeInsets.symmetric(vertical: 20),
      crossAxisCount: 2,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      childAspectRatio: 3,
      children: controller.listCustomerObs
          .map((element) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.primary.withOpacity(0.04)),
                child: _buildItem(element),
              ))
          .toList(),
    );
  }

  Widget _buildItem(CustomerModel model) {
    return InkWell(
      onTap: () => controller.onTapDetail(model),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: model.timeOut != null ? AppColors.colorGrey797979 : Colors.green,
                ),
              ),
              8.horizontalSpace,
              Expanded(
                child: Text(
                  model.displayName,
                  style: _textTheme.headline6!.bold,
                ),
              ),
            ],
          ),
          10.verticalSpace,
          Text(
            model.company,
            style: _textTheme.subtitle1!.textGrey797979,
          ),
          10.verticalSpace,
          Text(
            'Time in: ${model.timeIn.formatDateTime('HH:mm a')} ${model.timeOut != null ? '| Time out: ${model.timeOut!.formatDateTime('HH:mm a')}' : ''}'
                .trim(),
            style: _textTheme.subtitle2!.textGrey797979,
          ),
        ],
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
          controller.keySearchController.text.isNotEmpty ? 'Result Not Found' : 'No Visitor Yet!',
          style: _textTheme.headline5!.w8.textGrey797979,
        ),
        5.verticalSpace,
        if (controller.keySearchController.text.isNotEmpty)
          Text(
            'Please try again with another keywords',
            style: _textTheme.subtitle1!.textGreyBBBBBB,
            textAlign: TextAlign.center,
          ),
        100.verticalSpace,
      ],
    );
  }
}
