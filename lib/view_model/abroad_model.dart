import 'package:flutter_season/config/storage_manager.dart';
import 'package:flutter_season/model/abroad_res.dart';
import 'package:flutter_season/provider/view_state_model.dart';
import 'package:flutter_season/service/season_service.dart';

import 'user_model.dart';

class AbroadModel extends ViewStateModel {

  List<RegionList> _regionList = [];

  List<RegionList> get regionList => _regionList;

  Future<bool> getAbroadData() async {
    setBusy(true);
    try {
      var result = await SeasonService.getAbroadData();
      _regionList = result.regionList;
      setBusy(false);
      return true;
    } catch (e) {
      setError(e is Error ? e.toString() : e.message);
      return false;
    }
  }
}
