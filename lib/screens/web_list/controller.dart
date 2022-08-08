// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:app_visitor/common/common.dart';
import 'package:app_visitor/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../repository/repository.dart';

class WebManagerController extends GetxController {
  IFirebaseRepository get _firebaseRepo => Get.find();

  final customers = <CustomerModel>[];

  final date = DateTime.now().obs;

  @override
  void onInit() {
    _initLoad();
    super.onInit();
    Timer.periodic(10.seconds, (_) {
      _fetchCustomer();
    });
  }

  void _initLoad() async {
    EasyLoading.show();
    await _fetchCustomer();
    EasyLoading.dismiss();
  }

  Future _fetchCustomer() async {
    try {
      customers.clear();
      final res = await _firebaseRepo.fetchListCustomer(date: date.value);
      res.sort(
          (a, b) => b.timeIn.microsecondsSinceEpoch.compareTo(a.timeIn.microsecondsSinceEpoch));
      customers.addAll(res);
      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void onTapChangeDate() async {
    final result = await Get.dialog(
      DatePickerDialog(
        initialDate: date.value,
        firstDate: DateTime(2020),
        lastDate: DateTime.now(),
      ),
    );
    if (result != null && result is DateTime) {
      date.value = result;
      _initLoad();
    }
  }

  void onTapViewFile(CustomerModel model) async {
    if (await canLaunchUrlString(model.urlPdf)) {
      launch(model.urlPdf);
    } else {
      FlutterToast.showToastError(message: 'File does not exist!');
    }
  }
}
