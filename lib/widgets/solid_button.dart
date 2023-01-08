import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/style.dart';

class SolidButton extends StatelessWidget {
  const SolidButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.textStyle,
    this.isLarge = false,
    this.backgroundColor = Style.secondaryColor,
    this.iconData,
    this.iconColor = Style.lightGrayColor,
  }) : super(key: key);

  final String text;
  final Function()? onPressed;
  final TextStyle? textStyle;
  final bool isLarge;

  /// Button background color is default [Style.secondaryColor]
  final Color backgroundColor;
  final IconData? iconData;

  /// Icon color is default [Style.lightGrayColor]
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    if (iconData != null) {
      return _buildWithIcon(context);
    }
    return _buildDefault(context);
  }

  Widget _buildDefault(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1000),
            side: BorderSide(
              width: 1,
              color: Theme.of(context).shadowColor.withOpacity(0.3),
            )),
        padding: EdgeInsets.symmetric(
          horizontal: Style.defaultPadding,
          vertical: Style.defaultPadding * 0.5,
        ),
      ),
      onPressed: onPressed,
      child: SizedBox(
        width: isLarge ? double.infinity : null,
        child: Center(
          child: Text(
            text,
            style: textStyle ??
                TextStyle(
                  color: Theme.of(context).shadowColor.withOpacity(1),
                  fontSize: 48.sp,
                ),
          ),
        ),
      ),
    );
  }

  Widget _buildWithIcon(BuildContext context) {
    final icon = Icon(
      iconData,
      color: iconColor,
      size: isLarge ? Style.defaultIconSize * 0.75 : Style.defaultIconSize / 2,
    );
    return ElevatedButton.icon(
      icon: icon,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).shadowColor.withOpacity(1),
        shape: const StadiumBorder(),
        side: BorderSide(
          width: 1,
          color: Theme.of(context).shadowColor.withOpacity(0.4),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: Style.defaultPadding,
          vertical: Style.defaultPadding * 0.5,
        ),
      ),
      onPressed: onPressed,
      label: SizedBox(
        width: isLarge ? double.infinity : null,
        child: Center(
          child: Text(
            text,
            style: textStyle ?? Theme.of(context).textTheme.button,
          ),
        ),
      ),
    );
  }
}
