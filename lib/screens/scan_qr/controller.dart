import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scan/scan.dart';

import '../../repository/repository.dart';
import 'widget/widget.dart';

class ScanQRController extends GetxController {
  IFirebaseRepository get _firebaseRepo => Get.find();

  final qrKey = GlobalKey(debugLabel: 'QR');

  final scanController = ScanController();

  QRViewController? qrController;

  bool checkoutSuccess = false;

  void _checkout(String id) async {
    EasyLoading.show();
    final res = await _firebaseRepo.updateTimeOut(id: int.parse(id));
    EasyLoading.dismiss();
    if (res) {
      checkoutSuccess = true;
      update();
    } else {
      qrController!.resumeCamera();
    }
  }

  void confirmCheckout(String id) async {
    Get.bottomSheet(BottomSheetConfirmCheckout(
      onTapSure: () => _checkout(id),
      onTapCancel: () {
        qrController!.resumeCamera();
      },
    ));
  }

  void addManually() async {
    try {
      qrController!.pauseCamera();
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        final id = await Scan.parse(image.path);
        confirmCheckout(id ?? '');
      } else {
        qrController!.resumeCamera();
      }
    } catch (e) {
      qrController!.resumeCamera();
      debugPrint(e.toString());
    }
  }
}
