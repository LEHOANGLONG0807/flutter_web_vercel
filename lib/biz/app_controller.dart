import 'package:get/get.dart';

import '../repository/repository.dart';

class AppController extends GetxController {
  IFirebaseRepository get _firebaseRepo => Get.find();

  int countCustomer = 0;

  @override
  void onInit() {
    super.onInit();
    _countCustomer();
  }

  void _countCustomer() async {
    final res = await _firebaseRepo.fetchListCustomer(date: DateTime.now());
    countCustomer = res.length;
  }

  void addCountCustomer() {
    countCustomer++;
  }
}
