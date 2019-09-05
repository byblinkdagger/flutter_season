import 'package:flutter_season/model/home.dart';
import 'package:flutter_season/provider/view_state_list_model.dart';
import 'package:flutter_season/provider/view_state_model.dart';
import 'package:flutter_season/service/season_service.dart';

class HomeViewModel extends ViewStateModel {
  List<Bean0101> _banners = [];
  List<Bean0102> _topGoods = [];

  List<Bean0101> get banners => _banners;

  List<Bean0102> get topGoods => _topGoods;

//  set banners(List<Bean0101> banner) {
//    _banners = banner;
//    notifyListeners();
//  }
//
//  set topGoods(List<Bean0102> goods) {
//    _topGoods = goods;
//    notifyListeners();
//  }

//  @override
  Future<bool> loadData() async {
    setBusy(true);
    var result = await SeasonService.fetchHomeData();
    _banners = result.bean0101;
    _topGoods = result.bean0102;
    print("_banners :" + result.bean0101.toString());
//    notifyListeners();
    setBusy(false);
    return true;
  }
}
