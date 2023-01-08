import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:order_tracking_app/screens/home/home_screen.dart';
import 'package:order_tracking_app/screens/login/login_screen.dart';
import 'package:order_tracking_app/screens/not_found/not_found_screen.dart';
import 'package:order_tracking_app/view_models/add_order_viewmodel.dart';
import 'package:order_tracking_app/view_models/order_viewmodel.dart';
import 'package:provider/provider.dart';

import '../view_models/loading_viewmodel.dart';

class Routes {
  Routes._();

  static const String loginScreen = '/loginScreen';
  static const String homeScreen = '/homeScreen';

  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginScreen:
        return _getPageRoute(LoginScreen());
      case homeScreen:
        return _getPageRoute(MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => AddOrderViewModel()),
              ChangeNotifierProvider(create: (_) => LoadingViewModel()),
              ChangeNotifierProvider(create: (_) => OrderViewModel()),
            ],
            child: const HomeScreen()));
      default:
        return _getPageRoute(const NotFoundPage());
    }
  }

  static PageRoute _getPageRoute(Widget widget) {
    if (Platform.isIOS) {
      return CupertinoPageRoute(
        builder: (context) => widget,
      );
    } else {
      return MaterialPageRoute(
        builder: (context) => widget,
      );
    }
  }
}
