import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:order_tracking_app/constants/dimension.dart';

import '../../../constants/style.dart';

class BottomNavBar extends StatelessWidget {
  final Function(int) onItemTapped;
  final int index;

  const BottomNavBar({Key? key, required this.onItemTapped, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: index,
      color: Style.primaryColor,
      backgroundColor: Colors.transparent,
      height: Dimension.bottomNavBarHeight,
      buttonBackgroundColor: Style.secondaryColor,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      onTap: onItemTapped,
      items: [
        _getNavBarItem('assets/icons/home_door.svg'),
        _getNavBarItem('assets/icons/plus.svg'),
        _getNavBarItem('assets/icons/search.svg'),
        _getNavBarItem('assets/icons/sign-out.svg'),
      ],
    );
  }

  Widget _getNavBarItem(String iconPath) {
    return Container(
      padding: EdgeInsets.all(8),
      child: SvgPicture.asset(
        iconPath,
        color: Colors.white,
        height: Dimension.bottomNavBarHeight/2,
      ),
    );
  }
}
