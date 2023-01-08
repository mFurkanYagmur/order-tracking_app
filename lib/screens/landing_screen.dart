import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:order_tracking_app/constants/routes.dart';
import 'package:order_tracking_app/data/preferences_helper.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _navigateToPage(context);
    });
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future _navigateToPage(BuildContext context) async {
    bool isLogin = await PreferencesHelper.instance.getIsLogin();
    Navigator.pushNamedAndRemoveUntil(context, isLogin ? Routes.homeScreen : Routes.loginScreen, (route) => false);
  }
}
