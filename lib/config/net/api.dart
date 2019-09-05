import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_season/provider/view_state.dart';
import 'http.dart';
export 'package:dio/dio.dart';

/// 玩Android API
class ApiInterceptor extends InterceptorsWrapper {
  static const baseUrl = 'http://139.196.194.72:6060/';

  @override
  onRequest(RequestOptions options) {
    options.baseUrl = baseUrl;
    debugPrint('---api-request--->url--> ${options.baseUrl}${options.path}' +
        ' queryParameters: ${options.queryParameters}');
    debugPrint('---api-request--->data--->${options.data}');
    return options;
  }

  @override
  onResponse(Response response) {
    var statusCode = response.statusCode;
    if (statusCode != 200) {
      /// 非200会在http的onError()中
    } else {
//      debugPrint('---api-response--->resp----->${response.data}');
      if (response.data is Map) {
        RespData respData = RespData.fromJson(response.data);
        if (respData.success) {
          response.data = respData.data;
          return http.resolve(response);
        } else {
          return handleFailed(respData);
        }
      } else {
        /// WanAndroid API 如果报错,返回的数据类型存在问题
        /// eg: 没有登录的返回的值为'{"Code":-1001,"errorMsg":"请先登录！"}'
        /// 虽然是json样式,但是[response.headers.contentType?.mimeType]的值为'text/html'
        /// 导致dio没有解析为json对象.两种解决方案:
        /// 1.在post/get方法前加入泛型(Map),让其强制转换
        /// 2.在这里统一处理再次解析
        debugPrint('---api-response--->error--not--map---->$response');
        RespData respData = RespData.fromJson(json.decode(response.data));
        return handleFailed(respData);
      }
    }
  }

  Future<Response> handleFailed(RespData respData) {
    debugPrint('---api-response--->error---->$respData');
    if (respData.code == "9903") {
      // 由于cookie过期,所以需要清除本地存储的登录信息
//      StorageManager.localStorage.deleteItem(UserModel.keyUser);
      // 需要登录
      throw const UnAuthorizedException();
    }
    return http.reject(respData.message);
  }
}

class RespData {
  dynamic data;
  String code;
  String message;

  bool get success => "0000" == code;

  RespData({this.data, this.code, this.message});

  @override
  String toString() {
    return 'RespData{data: $data, status: $code, message: $message}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Code'] = this.code;
    data['Message'] = this.message;
    data['Content'] = this.data;
    return data;
  }

  RespData.fromJson(Map<String, dynamic> json) {
    code = json['Code'];
    message = json['Message'];
    data = json['Content'];
  }
}


