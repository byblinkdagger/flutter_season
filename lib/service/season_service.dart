import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_season/config/net/http.dart';
import 'package:flutter_season/model/home.dart';

class SeasonService {
  // 轮播
  static Future<HomeModel> fetchHomeData() async {
    FormData formData = new FormData.from({
      "Type": "0301"
    });
    var response = await http.post('',data: formData);
//    var response = await http.post('',data: {"Type": "0301"},options:new Options(contentType:ContentType.parse("application/x-www-form-urlencoded")));
    return HomeModel.fromJson(response.data);
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
