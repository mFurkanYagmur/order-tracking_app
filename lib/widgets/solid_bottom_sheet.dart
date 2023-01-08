import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/style.dart';

class SolidBottomSheet extends StatelessWidget {
  SolidBottomSheet({Key? key, required this.builder}) : super(key: key);

  Widget Function(BuildContext context) builder;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Dialog(
        alignment: Alignment.bottomCenter,
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(Style.defaultRadiusSize)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  height: 15.r,
                  width: 100.r,
                  margin: EdgeInsets.all(Style.defaultPadding/2),
                  decoration: BoxDecoration(
                    color: Theme.of(context).shadowColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(1000),
                  ),
                ),
              ),
              SingleChildScrollView(child: builder(context)),
            ],
          ),
        ),
      ),
    );
  }
}