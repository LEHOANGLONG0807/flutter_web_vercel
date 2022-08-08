import 'dart:io';
import 'dart:typed_data';
import 'package:app_visitor/biz/biz.dart';
import 'package:app_visitor/common/common.dart';
import 'package:app_visitor/models/models.dart';
import 'package:app_visitor/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'widget/widget.dart';

class FormController extends GetxController {
  IFirebaseRepository get _firebaseRepo => Get.find();

  AppController get _appCtrl => Get.find();

  final isInitialsNameRequires = true.obs;

  final firstNameController = TextEditingController();

  final lastNameController = TextEditingController();

  final companyController = TextEditingController();

  final purposeController = TextEditingController();

  final initialsNameController = TextEditingController();

  final formKey = GlobalKey<FormBuilderState>();

  bool isEnabled = true;

  final initial = ''.obs;

  int id = -1;

  String get idCreateCustomer =>
      'HTH-${DateTime.now().formatDateTime('MMddyy')}-${_appCtrl.countCustomer}';

  late CustomerModel _customerModel;

  final fileImage = Rx<dynamic>('');

  @override
  void onInit() {
    if (Get.arguments != null && Get.arguments is CustomerModel) {
      isEnabled = false;
      _customerModel = Get.arguments;
      _initData();
    }
    super.onInit();
  }

  void _initData() {
    isInitialsNameRequires.value = true;
    initialsNameController.text = _customerModel.initialsName;
    purposeController.text = _customerModel.purpose;
    companyController.text = _customerModel.company;
    firstNameController.text = _customerModel.firstName;
    lastNameController.text = _customerModel.lastName;
    fileImage.value = _customerModel.urlAvatar;
    update();
  }

  void _onTapSave() async {
    try {
      EasyLoading.show();
      final newModel = CustomerModel(
        dateIn: DateTime.now(),
        timeIn: DateTime.now(),
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        company: companyController.text.trim(),
        purpose: purposeController.text.trim(),
        initialsName: initialsNameController.text.trim(),
        customerId: _genCustomerId,
      );
      final data = newModel.toJson();
      data.removeWhere((key, value) => value == null);
      final res = await _firebaseRepo.createCustomer(data: data);

      if (res != null) {
        _appCtrl.addCountCustomer();
        final success = await _firebaseRepo.uploadAvatar(id: res, file: fileImage.value);
        EasyLoading.dismiss();
        if (success != true) {
          FlutterToast.showToastError(message: 'Upload Check-in photo error');
          EasyLoading.dismiss();
          return;
        }
        id = res;
        newModel.id = res;
        _customerModel = newModel;
        _genFilePDFPrint(model: _customerModel);
        update();
      }
    } catch (e) {
      EasyLoading.dismiss();
      FlutterToast.showToastError(message: 'An error occurred!');
    }
  }

  String get _genCustomerId =>
      'HTH-${DateTime.now().formatDateTime('MMddyy')}-${_appCtrl.countCustomer + 1}';

  void onTapSecurity() {
    Get.bottomSheet(BottomSheetSecurity(), isScrollControlled: true);
  }

  void onSubmit() {
    if (formKey.currentState!.validate()) {
      if (fileImage.value is! File) {
        FlutterToast.showToastError(message: 'Check-in photo is required');
        return;
      }
      Get.bottomSheet(BottomSheetConfirmSubmit(
        onTapSure: _onTapSave,
      ));
      return;
    }
  }

  void _genFilePDFPrint({required CustomerModel model}) async {
    EasyLoading.show();
    final imageUrl = 'https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=${model.id}';
    final bytes =
        (await NetworkAssetBundle(Uri.parse(imageUrl)).load(imageUrl)).buffer.asUint8List();
    ByteData byteData = await rootBundle.load('img_logo_company'.assetImagesPathPNG);

    final logoCompany = byteData.buffer.asUint8List();

    try {
      final uInt8ListPDF = await _generatePdf(PdfPageFormat.legal,
          byteQrCode: bytes, customer: model, logoCompany: logoCompany);
      _firebaseRepo.uploadFilePdf(id: model.id, file: uInt8ListPDF);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void checkInImage() async {
    try {
      final xFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front,
        maxWidth: 1000,
        maxHeight: 2000,
      );
      if (xFile != null) {
        fileImage.value = await File(xFile.path).create();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void initials() {
    String _initial = '';
    if (firstNameController.text.isNotEmpty && lastNameController.text.isNotEmpty) {
      _initial += firstNameController.text[0];
      _initial += lastNameController.text[0];
    }
    initial.value = _initial;
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format,
      {required CustomerModel customer,
      required Uint8List byteQrCode,
      required Uint8List logoCompany}) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    const newFormat = PdfPageFormat(125, 180, marginLeft: 10, marginRight: 36);
    EasyLoading.dismiss();
    pdf.addPage(
      ViewFormPrinting(
        pageFormat: newFormat,
        byteQrCode: byteQrCode,
        customer: customer,
        logoCompany: logoCompany,
      ).page,
    );
    return pdf.save();
  }
}
