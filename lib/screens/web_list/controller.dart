// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:app_visitor/common/common.dart';
import 'package:app_visitor/models/models.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../repository/repository.dart';

class WebManagerController extends GetxController {
  IFirebaseRepository get _firebaseRepo => Get.find();

  final customers = <CustomerModel>[];

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
    customers.clear();
    final res = await _firebaseRepo.fetchListCustomerManager();
    res.sort((a, b) => b.timeIn.microsecondsSinceEpoch.compareTo(a.timeIn.microsecondsSinceEpoch));
    customers.addAll(res);
    update();
  }

  void onTapViewFile(CustomerModel model) async {
    if (await canLaunchUrlString(model.urlPdf)) {
      launch(model.urlPdf);
    } else {
      FlutterToast.showToastError(message: 'File does not exist!');
    }
  }
}
