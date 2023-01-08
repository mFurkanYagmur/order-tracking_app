import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:order_tracking_app/constants/routes.dart';
import 'package:order_tracking_app/constants/style.dart';
import 'package:order_tracking_app/screens/landing_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _closeSplashScreen();
    return ScreenUtilInit(
      designSize: const Size(1080, 2280),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routes.onGenerateRoute,
        title: 'Order Tracker',
        theme: Style.lightTheme,
        darkTheme: Style.darkTheme,
        home: const LandingScreen(),
      ),
    );
  }

  _closeSplashScreen() {
    FlutterNativeSplash.remove();
  }
}
