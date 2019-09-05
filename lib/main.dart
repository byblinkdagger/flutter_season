import 'package:flutter/material.dart';
import 'package:flutter_season/ui/router/splash.dart';
import 'package:flutter_season/view_model/theme_model.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'config/provider_manager.dart';
import 'config/router_config.dart';
import 'config/storage_manager.dart';
import 'config/ui_adapter_config.dart';

main() async {
  Provider.debugCheckInvalidValueType = null;

  /// 全局屏幕适配方案
  InnerWidgetsFlutterBinding.ensureInitialized()
    ..attachRootWidget(MyApp(future: StorageManager.init()))
    ..scheduleWarmUpFrame();
}

class MyApp extends StatelessWidget {

  /// 在App运行之前,需要初始化的异步操作
  /// 如果存在多个,可以使用[Future.wait(futures)]来合并future后传入
  final Future future;

  const MyApp({this.future});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          /// 在异步操作时,显示的页面
          if (snapshot.connectionState != ConnectionState.done) {
            return SplashImage();
          }
          return OKToast(
              child: MultiProvider(
                  providers: providers,
                  child: Consumer<ThemeModel>(
                      builder: (context, themeModel, child) {
                        return RefreshConfiguration(
                          hideFooterWhenNotFull: true, //列表数据不满一页,不触发加载更多
                          child: MaterialApp(
                            debugShowCheckedModeBanner: false,
                            theme: themeModel.themeData,
                            darkTheme: themeModel.darkTheme,
                            onGenerateRoute: Router.generateRoute,
                            initialRoute: RouteName.splash,
                          ),
                        );
                      })));
        });
  }
}
