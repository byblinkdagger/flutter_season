import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_season/ui/page_route_anim.dart';
import 'package:flutter_season/ui/router/home_page.dart';
import 'package:flutter_season/ui/router/splash.dart';


class RouteName {
  static const String splash = 'splash';
  static const String home = '/';
}

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splash:
        return MaterialPageRoute(builder:(context) =>SplashPage());
      case RouteName.home:
        return MaterialPageRoute(builder:(context) =>MyHomePage(title: '首页'));
    }
  }
}

/// Pop路由
class PopRoute extends PopupRoute {
  final Duration _duration = Duration(milliseconds: 300);
  Widget child;

  PopRoute({@required this.child});

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;
}
