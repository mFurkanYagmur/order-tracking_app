import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'background_wave.dart';

class PageTitle extends StatelessWidget {
  final double height, width;

  const PageTitle({Key? key, required this.height, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Stack(
        children: [
          BackgroundWaveWidget(
            radius: height / 3,
            topSpace: height / 3,
            size: Size(width, height),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 2,
                child: Center(
                  child: SizedBox(
                    height: height / 3,
                    width: width / 3,
                    child: _buildLogo(),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'login'.tr(),
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return SvgPicture.asset('assets/icons/logo.svg');
  }
}
