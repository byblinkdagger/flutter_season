import 'package:flutter_season/model/goods_res.dart';
import 'package:flutter_season/model/home.dart';
import 'package:flutter_season/provider/view_state_list_model.dart';
import 'package:flutter_season/provider/view_state_model.dart';
import 'package:flutter_season/service/season_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class GoodsViewModel extends ViewStateModel {

  String cCode;

  GoodsViewModel(this.cCode);

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  RefreshController get refreshController => _refreshController;

  GoodsRes _goodsRes;

  get goodsRes => _goodsRes;
//  set banners(List<Bean0101> banner) {
//    _banners = banner;
//    notifyListeners();
//  }
//

//  @override
  Future<bool> getGoodsData() async {
    setBusy(true);
    var result = await SeasonService.getGoodsData(cCode);
    _goodsRes = result;
    refreshController.refreshCompleted();
    setBusy(false);
    return true;
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}
