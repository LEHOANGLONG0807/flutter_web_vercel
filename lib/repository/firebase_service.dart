import 'dart:io';

import 'package:app_visitor/common/common.dart';
import 'package:app_visitor/models/customer_model.dart';
import 'package:app_visitor/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirebaseService {
  FirebaseService() {
    final _firebaseFirestore = FirebaseFirestore.instance;

    storage = FirebaseStorage.instance;

    customerCollection = _firebaseFirestore.collection('customers');
  }
  late CollectionReference customerCollection;

  late FirebaseStorage storage;
}

abstract class IFirebaseRepository {
  Future<String?> createCustomer({required Map<String, dynamic> data});

  Future<bool> updateTimeOut({required String id});

  Future<bool> updateURLPDF({required String id, required String urlPdf});

  Future<bool> checkHaveId({required String id});

  Future<String?> uploadImage({required File file});

  Future<String?> uploadFilePdf({required File file});

  Future<List<CustomerModel>> fetchListCustomer({required DateTime date});

  Future<List<CustomerModel>> fetchListCustomerManager();
}

class FirebaseRepository implements IFirebaseRepository {
  FirebaseService get _firebaseService => Get.find();

  @override
  Future<String?> createCustomer({required Map<String, dynamic> data}) async {
    try {
      final res = await _firebaseService.customerCollection.add(data);
      return res.id;
    } catch (e) {
      debugPrint(e.toString());
      FlutterToast.showToastError(message: 'Error!');
      return null;
    }
  }

  @override
  Future<bool> updateTimeOut({required String id}) async {
    try {
      await _firebaseService.customerCollection
          .doc(id)
          .update({'time_out': DateTime.now().toIso8601String()});
      return true;
    } catch (e) {
      debugPrint(e.toString());
      FlutterToast.showToastError(message: 'ID not found!');
      return false;
    }
  }

  @override
  Future<List<CustomerModel>> fetchListCustomer({required DateTime date}) async {
    try {
      final res = await _firebaseService.customerCollection
          .where('date_in', isEqualTo: date.formatDateddMMyyyy)
          .get();
      final list = res.docs.toList();
      return list.map((e) {
        final newModel = CustomerModel.fromJson(e.data() as Map<String, dynamic>);
        newModel.id = e.id;
        return newModel;
      }).toList();
    } catch (e) {
      debugPrint(e.toString());
      FlutterToast.showToastError(message: 'Error!');
    }

    return [];
  }

  @override
  Future<bool> checkHaveId({required String id}) async {
    try {
      final res = await _firebaseService.customerCollection.doc(id).get();
      return res.data() != null;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  @override
  Future<String?> uploadImage({required File file}) async {
    try {
      final ref = _firebaseService.storage.ref().child('images/${file.path.split('/').last}');
      final res = await ref.putFile(file);
      final url = await res.ref.getDownloadURL();
      return url;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  @override
  Future<String?> uploadFilePdf({required File file}) async {
    try {
      final ref = _firebaseService.storage.ref('files').child(file.path.split('/').last);
      final res = await ref.putFile(file);
      final url = await res.ref.getDownloadURL();
      return url;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  @override
  Future<List<CustomerModel>> fetchListCustomerManager() async {
    try {
      final res = await _firebaseService.customerCollection
          .where('date_in', isEqualTo: DateTime.now().formatDateddMMyyyy)
          .limit(20)
          .get();
      final list = res.docs.toList();
      return list.map((e) {
        final newModel = CustomerModel.fromJson(e.data() as Map<String, dynamic>);
        newModel.id = e.id;
        return newModel;
      }).toList();
    } catch (e) {
      debugPrint(e.toString());
      FlutterToast.showToastError(message: 'Error!');
    }

    return [];
  }

  @override
  Future<bool> updateURLPDF({required String id, required String urlPdf}) async {
    try {
      await _firebaseService.customerCollection.doc(id).update({'url_pdf': urlPdf});
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
