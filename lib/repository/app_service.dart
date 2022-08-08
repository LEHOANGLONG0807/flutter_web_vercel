
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';

import '../biz/biz.dart';
import '../common/common.dart';
import '../models/models.dart';

const pageSizeResult = 20;

class AppService extends BaseService {
  AppService() {
    initAppService();
  }

  Future<BaseResponseModel> get(String path,
      {Map<String, dynamic>? queryParameters,
      Function(String)? customErrorRes,
      Function(DioError)? customErrorCatch}) async {
    try {
      debugPrint('---PATH---\nGET:$path');
      debugPrint('---PARAMS---\n:${queryParameters ?? ''}');
      final res = await _dio.get(path, queryParameters: queryParameters);
      debugPrint('---RESPONSE-$path--:\n$res');
      if (isSuccess(res)) {
        return BaseResponseModel(isSuccess: true, data: responseData(res));
      } else {
        EasyLoading.dismiss();
        if (customErrorRes != null) {
          customErrorRes.call(getMegError(res));
        } else {
          FlutterToast.showToastError(message: getMegError(res));
        }
      }
    } catch (e) {
      if (customErrorCatch != null) {
        customErrorCatch.call(e as DioError);
      } else {
        checkError(e as DioError);
      }
    }
    return BaseResponseModel(isSuccess: false, data: null);
  }

  Future<BaseResponseModel> post(String path,
      {Map<String, dynamic>? queryParameters,
      dynamic data,
      Function(String)? customErrorRes,
      Function(DioError)? customErrorCatch}) async {
    try {
      debugPrint('---PATH---\nPOST:$path');
      debugPrint('---PARAMS---\n:${queryParameters ?? ''}');
      debugPrint('---DATA---\n:${data ?? ''}');
      final res = await _dio.post(path, queryParameters: queryParameters, data: data);
      debugPrint('---RESPONSE---\n$res');
      if (isSuccess(res)) {
        return BaseResponseModel(isSuccess: true, data: responseData(res));
      } else {
        EasyLoading.dismiss();
        if (customErrorRes != null) {
          customErrorRes.call(getMegError(res));
        } else {
          FlutterToast.showToastError(message: getMegError(res));
        }
      }
    } catch (e) {
      if (customErrorCatch != null) {
        customErrorCatch.call(e as DioError);
      } else {
        checkError(e as DioError);
      }
    }
    return BaseResponseModel(isSuccess: false, data: null);
  }

  Future<BaseResponseModel> put(String path,
      {Map<String, dynamic>? queryParameters, dynamic data}) async {
    try {
      debugPrint('---PATH---\nPUT:$path');
      debugPrint('---PARAMS---\n:${queryParameters ?? ''}');
      debugPrint('---DATA---\n:${data ?? ''}');
      final res = await _dio.put(path, queryParameters: queryParameters, data: data);
      debugPrint('---RESPONSE---\n$res');
      if (isSuccess(res)) {
        return BaseResponseModel(isSuccess: true, data: responseData(res));
      } else {
        EasyLoading.dismiss();
        FlutterToast.showToastError(message: getMegError(res));
      }
    } catch (e) {
      checkError(e as DioError);
    }
    return BaseResponseModel(isSuccess: false, data: null);
  }

  Future<BaseResponseModel> patch(String path,
      {Map<String, dynamic>? queryParameters, dynamic data}) async {
    try {
      debugPrint('---PATH---\nPATCH:$path');
      debugPrint('---PARAMS---\n:${queryParameters ?? ''}');
      debugPrint('---DATA---\n:${data ?? ''}');
      final res = await _dio.patch(path, queryParameters: queryParameters, data: data);
      debugPrint('---RESPONSE---\n$res');
      if (isSuccess(res)) {
        return BaseResponseModel(isSuccess: true, data: responseData(res));
      } else {
        EasyLoading.dismiss();
        FlutterToast.showToastError(message: getMegError(res));
      }
    } catch (e) {
      checkError(e as DioError);
    }
    return BaseResponseModel(isSuccess: false, data: null);
  }

  Future<BaseResponseModel> delete(String path,
      {Map<String, dynamic>? queryParameters, dynamic data}) async {
    try {
      debugPrint('---PATH---\nDELETE:$path');
      debugPrint('---PARAMS---\n:${queryParameters ?? ''}');
      debugPrint('---DATA---\n:${data ?? ''}');
      final res = await _dio.delete(path, queryParameters: queryParameters, data: data);
      debugPrint('---RESPONSE---\n$res');
      if (isSuccess(res)) {
        return BaseResponseModel(isSuccess: true, data: responseData(res));
      } else {
        EasyLoading.dismiss();
        FlutterToast.showToastError(message: getMegError(res));
      }
    } catch (e) {
      checkError(e as DioError);
    }
    return BaseResponseModel(isSuccess: false, data: null);
  }
}

abstract class BaseService {
  late Dio _dio;
  String? _token;
  final _stg = GetStorage();

  void initAppService() {
    final headers = <String, dynamic>{
      'content-type': 'application/json',
      'accept': 'application/json',
    };
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://visitor.hthcomm.com/api',
        connectTimeout: 15000,
        receiveTimeout: 15000,
        responseType: ResponseType.json,
        headers: headers,
      ),
    );
  }

  void setToken(String? token) {
    _stg.write(AppConstants.keyToken, token);
    _token = token;
    initAppService();
  }

  bool isSuccess(dio.Response response) {
    return response.statusCode == 200 &&
        (response.data['success'] == true || response.data['message'] == 'success');
  }

  String getMegError(dio.Response response) {
    return response.data['message'];
  }

  dynamic responseData(var response) {
    try {
      return response.data['data'];
    } catch (e) {
      return response.data;
    }
  }

  void checkError(DioError e) {
    EasyLoading.dismiss();
    debugPrint('---ERROR---\n${e.toString()}');
    if (e.response?.statusCode == 401) {
    } else {
      try {
        FlutterToast.showToastError(message: e.response!.data['error']);
      } catch (E) {
        FlutterToast.showToastError(message: 'An error occurred!');
      }
    }
  }
}
