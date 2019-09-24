import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_season/config/net/http.dart';
import 'package:flutter_season/model/abroad_res.dart';
import 'package:flutter_season/model/goods_res.dart';
import 'package:flutter_season/model/home.dart';
import 'package:flutter_season/model/login_res.dart';
import 'dart:convert' as convert;
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

class SeasonService {
  // 轮播
  static Future<HomeModel> fetchHomeData() async {
    FormData formData = new FormData.from({
      "Type": "0301"
    });
    var response = await http.post('', data: formData);
//    var response = await http.post('',data: {"Type": "0301"},options:new Options(contentType:ContentType.parse("application/x-www-form-urlencoded")));
    return HomeModel.fromJson(response.data);
  }

  // 登录
  static Future<LoginRes> login(String username, String password) async {
    String json = convert.jsonEncode({
      "cMobile": username,
      "Password": generateMd5(password),
      "logintype": "01",
      "VerCode": "",
    });
    FormData formData = new FormData.from({
    "Type": "0106",
    "cPutText":json
    });
    var response = await http.post('', data: formData);
//    var response = await http.post('',data: {"Type": "0301"},options:new Options(contentType:ContentType.parse("application/x-www-form-urlencoded")));
    if (null != response.data)
      return LoginRes.fromJson(response.data);
    return null;
  }

  // 全球看全球购接口
  static Future<AbroadRes> getAbroadData() async {
    String json = convert.jsonEncode({"globalType":"GlobalWatch"});
    FormData formData = new FormData.from({
      "Type": "0501",
      "cPutText":json
    });
    var response = await http.post('', data: formData);
    return AbroadRes.fromJson(response.data);
  }

  // 获取商品详情
  static Future<GoodsRes> getGoodsData(String cCode) async {
    String json = convert.jsonEncode({
      "cCode": cCode,
    });
    FormData formData = new FormData.from({
      "Type": "0201",
      "cPutText":json
    });
    var response = await http.post('', data: formData);
//    var response = await http.post('',data: {"Type": "0301"},options:new Options(contentType:ContentType.parse("application/x-www-form-urlencoded")));
    return GoodsRes.fromJson(response.data);
  }

//  // 置顶文章
//  static Future fetchTopArticles() async {
//    var response = await http.get('article/top/json');
//    return response.data.map<Article>((item) => Article.fromMap(item)).toList();
//  }
//
//  // 文章
//  static Future fetchArticles(int pageNum, {int cid}) async {
//    await Future.delayed(Duration(seconds: 1));
//    var response = await http.get('article/list/$pageNum/json',
//        queryParameters: (cid != null ? {'cid': cid} : null));
//    return response.data['datas']
//        .map<Article>((item) => Article.fromMap(item))
//        .toList();
//  }
}

// md5 加密
String generateMd5(String data) {
  var content = new Utf8Encoder().convert(data);
  var digest = md5.convert(content);
  // 这里其实就是 digest.toString()
  return hex.encode(digest.bytes);
}