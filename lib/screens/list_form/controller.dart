import 'package:app_visitor/models/models.dart';
import 'package:app_visitor/repository/repository.dart';
import 'package:app_visitor/models/customer_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:slugify/slugify.dart';
import '../../routes/routes.dart';

class ListController extends GetxController {
  IFirebaseRepository get _firebaseRepo => Get.find();

  final listCustomerObs = <CustomerModel>[].obs;

  final _listCustomer = <CustomerModel>[];

  final keySearchController = TextEditingController();

  final totalVisitors = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _fetchCustomer();
  }

  void _fetchCustomer() async {
    EasyLoading.show();
    final res = await _firebaseRepo.fetchListCustomer(date: DateTime.now());
    _listCustomer.clear();
    res.sort((a, b) => b.timeIn.microsecondsSinceEpoch.compareTo(a.timeIn.microsecondsSinceEpoch));
    _listCustomer.addAll(res);
    totalVisitors.value = res.length;
    listCustomerObs.value = res;
    EasyLoading.dismiss();
  }

  void clearSearch() {
    keySearchController.clear();
    listCustomerObs.value = _listCustomer;
  }

  void onSearch(String key) {
    if (key.isEmpty) {
      listCustomerObs.value = _listCustomer;
    } else {
      final list = _listCustomer.where((element) {
        return _slug(element.firstName).contains(_slug(key)) ||
            _slug(element.lastName).contains(_slug(key)) ||
            _slug(element.displayName).contains(_slug(key)) ||
            _slug(element.company).contains(_slug(key));
      }).toList();
      listCustomerObs.value = list;
    }
  }

  String _slug(String val) => slugify(val, lowercase: true, delimiter: '');

  void onTapDetail(CustomerModel model) {
    Get.toNamed(Routes.form, arguments: model);
  }
}
