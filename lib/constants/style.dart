import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Style {
  static const Color primaryColor = Color(0xff171C30);
  static const Color secondaryColor = Color(0xffECBB07);
  static const Color primaryHintColor = Color(0x77171C30);//Color(0xff3B3E51);
  static const Color greenColor = Color(0xff30A056);
  static const Color redColor = Color(0xffA42E3C);

  static const Color dangerColor = Color(0xffF44336);
  static const Color successColor = Color(0xff4CAF50);
  static const Color warningColor = Color(0xffFF9800);
  static const Color infoColor = activeIcon;
  static const Color whiteColor = Colors.white;
  static const Color blackColor = Colors.black;
  static const Color transperent = Colors.transparent;
  static const Color svgIconColor = Color.fromARGB(255, 135, 129, 129);

  static final double titleSize = 60.r; //20
  static final double subTitleSize = 45.r; //16

  static const Color lightGrayColor = Color(0xffEFEFEF);
  static const Color appBgLight = Color(0xfff4f4f4);
  static const Color appBgDark = primaryColor;
  static const Color cardBgLight = Colors.white;
  static const Color cardBgDark = Color.fromARGB(255, 20, 25, 53);
  static const Color textColorLight = Color(0xff181c31);
  static const Color textColorDark = Color(0xfff0f0f0);
  static const Color textHintColorLight = primaryHintColor;
  static final Color textHintColorDark = Colors.white.withOpacity(0.6);
  static const Color unActiveIcon = Color.fromARGB(255, 180, 195, 239);
  static const Color activeIcon = Color.fromARGB(255, 89, 114, 190);
  static const Color secondaryAccentColor = Color(0xFFFF9933);
  static const Gradient darkToLightBlueGradient = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color(0xff1E3C50),
      Color(0xff0F5082),
    ],
  );
  static const String bahnschriftFont = 'Bahnschrift';
  static final double defaultPadding = 56.r; //16
  static final double defaultBorderSize = 8.r;
  static final double defaultRadiusSize = 28.r;
  static final double defaultElevationSize = defaultRadiusSize;
  static final double defaultIconSize = 96.r;
  static final double minimizeRadiusSize = 24.r;
  static final double defaultFontSize = 48.sp;
  static const Gradient secondaryGradient = LinearGradient(
    colors: [
      secondaryAccentColor,
      secondaryColor,
    ],
    begin: Alignment.bottomLeft,
    end: Alignment.topCenter,
  );

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Style.whiteColor,
    backgroundColor: appBgLight,
    fontFamily: bahnschriftFont,
    drawerTheme: const DrawerThemeData(backgroundColor: Style.whiteColor),
    textTheme: _getTextTheme(textColorLight),
    textSelectionTheme: _textSelectionLightTheme,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedItemColor: Style.primaryHintColor.withOpacity(0.9),
      backgroundColor: Style.whiteColor,
    ),
    focusColor: secondaryColor,
    highlightColor: secondaryColor.withOpacity(0.3),
    cardColor: cardBgLight,
    shadowColor: Style.primaryColor.withOpacity(0.1),
    hintColor: primaryHintColor,
    dividerTheme: _dividerTheme,
    iconTheme: const IconThemeData(color: Style.primaryColor),
    appBarTheme: _getAppBarTheme(Style.whiteColor, Style.primaryColor),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.transparent,
    ),
    indicatorColor: Style.secondaryColor,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Style.secondaryColor,
      circularTrackColor: Style.secondaryColor,
      linearTrackColor: Style.secondaryColor,
    ),
    errorColor: dangerColor,
    // primaryColor: primaryColor,
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: cardBgDark,
    brightness: Brightness.dark,
    drawerTheme: const DrawerThemeData(backgroundColor: Style.primaryColor),
    backgroundColor: appBgDark,
    fontFamily: bahnschriftFont,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedItemColor: Style.whiteColor.withOpacity(0.9),
      backgroundColor: Style.primaryColor,
    ),
    textTheme: _getTextTheme(textColorDark),
    textSelectionTheme: _textSelectionDarkTheme,
    focusColor: secondaryColor,
    shadowColor: Style.whiteColor.withOpacity(0.1),
    highlightColor: secondaryColor.withOpacity(0.3),
    cardColor: cardBgDark,
    hintColor: textHintColorDark,
    dividerTheme: _dividerTheme,
    iconTheme: const IconThemeData(color: Style.lightGrayColor),
    appBarTheme: _getAppBarTheme(appBgDark, Style.whiteColor),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.transparent,
    ),
    indicatorColor: Style.secondaryColor,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Style.secondaryColor,
      circularTrackColor: Style.secondaryColor,
      linearTrackColor: Style.secondaryColor,
    ),
    errorColor: dangerColor,
    // primaryColor: primaryColor,
  );

  static AppBarTheme _getAppBarTheme(Color color, Color iconColor) {
    return AppBarTheme(
      backgroundColor: color,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      iconTheme: IconThemeData(color: iconColor),
      actionsIconTheme: IconThemeData(color: iconColor),
    );
  }

  static TextTheme _getTextTheme(Color color) => TextTheme(
    ///  display-large
    headline1: TextStyle(
        fontSize: 288.0.sp,
        fontWeight: FontWeight.w300,
        color: color,
        wordSpacing: -1.5),

    ///  display-medium
    headline2: TextStyle(
        fontSize: 180.0.sp,
        fontWeight: FontWeight.w300,
        color: color,
        wordSpacing: -0.5),

    ///  display-small
    headline3: TextStyle(
        fontSize: 144.0.sp,
        fontWeight: FontWeight.w400,
        color: color,
        wordSpacing: 0.0),

    ///  headline-medium
    headline4: TextStyle(
        fontSize: 102.0.sp,
        fontWeight: FontWeight.w400,
        color: color,
        wordSpacing: 0.25),

    ///  headline-small
    headline5: TextStyle(
        fontSize: 72.0.sp,
        fontWeight: FontWeight.w400,
        color: color,
        wordSpacing: 0.0),

    ///  title-large
    headline6: TextStyle(
        fontSize: 60.0.sp,
        fontWeight: FontWeight.w500,
        color: color,
        wordSpacing: 0.15),

    ///  title-medium
    subtitle1: TextStyle(
        fontSize: 48.0.sp,
        fontWeight: FontWeight.w400,
        color: color,
        wordSpacing: 0.15),

    ///  title-small
    subtitle2: TextStyle(
        fontSize: 42.0.sp,
        fontWeight: FontWeight.w500,
        color: color,
        wordSpacing: 0.1),

    ///  body-large
    bodyText1: TextStyle(
        fontSize: 44.0.sp,
        fontWeight: FontWeight.w400,
        color: color,
        wordSpacing: 0.5),

    ///  body-medium
    bodyText2: TextStyle(
        fontSize: 40.0.sp,
        fontWeight: FontWeight.w400,
        color: color,
        wordSpacing: 0.25),

    ///  body-small
    caption: TextStyle(
        fontSize: 38.0.sp,
        fontWeight: FontWeight.w500,
        color: color,
        wordSpacing: 1.25),

    ///  label-large
    button: TextStyle(
        fontSize: 36.0.sp,
        fontWeight: FontWeight.w400,
        color: color,
        wordSpacing: 0.4),

    ///  label-small
    overline: TextStyle(
        fontSize: 30.0.sp,
        fontWeight: FontWeight.w400,
        color: color,
        wordSpacing: 1.5),
  );

  static final TextSelectionThemeData _textSelectionLightTheme =
  TextSelectionThemeData(
    cursorColor: primaryColor,
    selectionColor: secondaryColor.withOpacity(0.3),
    selectionHandleColor: secondaryColor,
  );

  static final TextSelectionThemeData _textSelectionDarkTheme =
  TextSelectionThemeData(
    cursorColor: secondaryColor,
    selectionColor: secondaryColor.withOpacity(0.3),
    selectionHandleColor: secondaryColor,
  );

  static final DividerThemeData _dividerTheme = DividerThemeData(
    color: secondaryColor,
    thickness: defaultBorderSize / 3,
    space: defaultPadding,
    indent: defaultPadding,
    endIndent: defaultPadding,
  );

  static LinearGradient linearGradientDefault = const LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      Colors.white,
      Color.fromARGB(255, 226, 232, 253),
      Color.fromARGB(255, 208, 220, 250),
      Color.fromARGB(255, 168, 186, 239),
    ],
  );
  static LinearGradient linearGradientDefaultKasa = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromARGB(255, 233, 236, 248),
      Color.fromARGB(255, 234, 239, 254),
      Color.fromARGB(255, 233, 239, 255),
    ],
  );
  static LinearGradient linearGradientDefaultDark = const LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      Color.fromARGB(255, 20, 25, 53),
      Color.fromARGB(255, 20, 25, 53),
    ],
  );
}

/*
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Style{
  static const Color primaryColor = Color(0xFF282842);
  static const Color primaryHintColor = Color(0xFFF9F9F9);
  static const Color secondaryColor = Color(0xFFFF8000);  //  0xFFF0F0F1
  static const Color successColor = Color(0xFF367E18);
  static const Color dangerColor = Color(0xFFCC3636);
  static const Color secondaryAccentColor = Color(0xFFFF9933);
  static const Color appBgColor = Color(0xFFFFFFFF);  //  0xFFF0F0F1
  static const Color textColor = Color(0xFF000000);
  static const Color textHintColor = Color(0xFFCECFCF);
  static const Gradient secondaryGradient = LinearGradient(
    colors: [
      secondaryAccentColor,
      secondaryColor,
    ],
    begin: Alignment.bottomLeft,
    end: Alignment.topCenter,
  );
  static double defaultPadding = 24.r;
  static double defaultRadius = 24.r;
  static double defaultIconSize = 24.r;
  static const String fontName = 'Roboto';
  static final ThemeData appTheme = ThemeData(
    primaryColor: primaryColor,
    backgroundColor: appBgColor,
    primaryIconTheme: IconThemeData(color: primaryColor),
    iconTheme: IconThemeData(color: Colors.white),
    fontFamily: fontName,
    textTheme: TextTheme(
      headline1: _getHeadlineTextStyle(32.sp),
      headline2: _getHeadlineTextStyle(28.sp),
      headline3: _getHeadlineTextStyle(24.sp),
      headline4: _getHeadlineTextStyle(20.sp),
      headline5: _getHeadlineTextStyle(16.sp),
      headline6: _getHeadlineTextStyle(14.sp),
      bodyText1: _getBody1TextStyle(),
      bodyText2: _getBody2TextStyle(),
      button: _getButtonTextStyle(),
      subtitle1: _getSubtitleTextStyle(16.sp),
      subtitle2: _getSubtitleTextStyle(24.sp),
    ),
  );

  static TextStyle _getButtonTextStyle() {
    return TextStyle(
      fontSize: 16.sp,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle _getHeadlineTextStyle(double fontSize) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: Style.textColor,
    );
  }

  static TextStyle _getSubtitleTextStyle(double fontSize) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: Style.textColor,
    );
  }

  static TextStyle _getBody1TextStyle() {
    return TextStyle(
      fontSize: 16.sp,
      color: Style.textColor,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle _getBody2TextStyle() {
    return TextStyle(
      fontSize: 16.sp,
      color: Style.textColor,
    );
  }
}*/
