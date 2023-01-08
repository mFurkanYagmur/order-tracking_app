import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:order_tracking_app/view_models/auth_viewmodel.dart';
import 'package:provider/provider.dart';

import 'app.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();

  // setupLocator();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('tr')],
      path: 'assets/translations',
      fallbackLocale: const Locale('tr'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AuthViewModel()),
        ],
        child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: const MyApp()),
      ),
    ),
  );
}
