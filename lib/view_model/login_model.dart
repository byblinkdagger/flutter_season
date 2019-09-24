
import 'package:flutter_season/config/storage_manager.dart';
import 'package:flutter_season/provider/view_state_model.dart';
import 'package:flutter_season/service/season_service.dart';

import 'user_model.dart';

const String kLoginName = 'kLoginName';

class LoginModel extends ViewStateModel {
  final UserModel userModel;

  LoginModel(this.userModel) : assert(userModel != null);

  String getLoginName() {
    return StorageManager.sharedPreferences.getString(kLoginName);
  }

  Future<bool> login(loginName, password) async {
    setBusy(true);
    try {
      var user = await SeasonService.login(loginName, password);
      setBusy(false);
      return true;
    } catch (e) {
      setError(e is Error ? e.toString() : e.message);
      return false;
    }
  }
}
