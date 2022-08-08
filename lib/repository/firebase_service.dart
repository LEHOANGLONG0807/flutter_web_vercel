import 'dart:io';
import 'dart:typed_data';

import 'package:app_visitor/common/common.dart';
import 'package:app_visitor/models/customer_model.dart';
import 'package:app_visitor/models/models.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'app_service.dart';

// class FirebaseService {
//   FirebaseService() {
//     final _firebaseFirestore = FirebaseFirestore.instance;
//
//     storage = FirebaseStorage.instance;
//
//     customerCollection = _firebaseFirestore.collection('customers');
//   }
//   late CollectionReference customerCollection;
//
//   late FirebaseStorage storage;
// }

abstract class IFirebaseRepository {
  Future<int?> createCustomer({required Map<String, dynamic> data});

  Future<bool> updateTimeOut({required int id});

  Future<bool> uploadAvatar({required int id, required File file});

  Future<bool> uploadFilePdf({required int id, required Uint8List file});

  Future<List<CustomerModel>> fetchListCustomer({required DateTime date});
}

class FirebaseRepository implements IFirebaseRepository {
  AppService get _appService => Get.find();

  @override
  Future<int?> createCustomer({required Map<String, dynamic> data}) async {
    try {
      final res = await _appService.post('/customers', data: data);
      if (res.isSuccess) {
        return res.data['id'];
      }
    } catch (e) {
      debugPrint(e.toString());
      FlutterToast.showToastError(message: 'Error!');
    }
    return null;
  }

  @override
  Future<bool> updateTimeOut({required int id}) async {
    try {
      final res = await _appService.put('/customers/checkout/$id');
      return res.isSuccess;
    } catch (e) {
      debugPrint(e.toString());
      FlutterToast.showToastError(message: 'ID not found!');
      return false;
    }
  }

  @override
  Future<List<CustomerModel>> fetchListCustomer({required DateTime date}) async {
    try {
      final res = await _appService.get(
          '/customers?date=${date.date.formatDateTime('MM/dd/yyyy')}-${date.date.add(24.hours).formatDateTime('MM/dd/yyyy')}&pageSize=100');
      if (res.isSuccess) {
        return (res.data['data'] as List).map((e) => CustomerModel.fromJson(e)).toList();
      }
    } catch (e) {
      debugPrint(e.toString());
      FlutterToast.showToastError(message: 'Error!');
    }

    return [];
  }

  @override
  Future<bool> uploadAvatar({required int id, required File file}) async {
    try {
      final List<int> imageData = file.readAsBytesSync();
      final multipartFile = dio.MultipartFile.fromBytes(
        imageData,
        filename: file.path,
        contentType: MediaType('image', 'jpg'),
      );
      final res = await _appService.post('/customers/uploadAvatar/$id',
          data: dio.FormData.fromMap({'avatar': multipartFile}));
      return res.isSuccess;
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }

  @override
  Future<bool> uploadFilePdf({required int id, required Uint8List file}) async {
    try {
      final multipartFile = dio.MultipartFile.fromBytes(
        file,
        filename: 'file_pdf_$id.pdf',
        contentType: MediaType('application', 'pdf'),
      );
      final res = await _appService.post('/customers/uploadPDF/$id',
          data: dio.FormData.fromMap({'file_printing': multipartFile}));
      return res.isSuccess;
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }
}
