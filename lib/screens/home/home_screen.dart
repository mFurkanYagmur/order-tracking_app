import 'package:flutter/material.dart';
import 'package:order_tracking_app/constants/routes.dart';
import 'package:order_tracking_app/screens/home/pages/add_order/add_order_page.dart';
import 'package:order_tracking_app/screens/home/pages/feed/feed_page.dart';
import 'package:order_tracking_app/screens/home/pages/search/search_page.dart';
import 'package:order_tracking_app/screens/home/pages/settings/settings_page.dart';
import 'package:order_tracking_app/view_models/add_order_viewmodel.dart';
import 'package:order_tracking_app/view_models/auth_viewmodel.dart';
import 'package:order_tracking_app/view_models/loading_viewmodel.dart';
import 'package:order_tracking_app/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

import 'components/bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int _currentIndex = 0;
  late List<Widget> _pageList;

  @override
  Widget build(BuildContext context) {
    bool loading = context.watch<LoadingViewModel>().loading;
    _pageList = [
      FeedPage(),
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: context.read<AddOrderViewModel>()),
        ],
        child: AddOrderPage(),
      ),
      const SearchPage(),
      const SettingsPage(),
    ];
    return Scaffold(
      // extendBody: true,
      bottomNavigationBar: loading
          ? null
          : BottomNavBar(
              index: _currentIndex,
              onItemTapped: (index) async {
                if (index == 3) {
                  await context.read<AuthViewModel>().signOut();
                  Navigator.pushNamedAndRemoveUntil(context, Routes.loginScreen, (route) => false);
                } else {
                  setState(() {
                    _currentIndex = index;
                  });
                }
              },
            ),
      body: SafeArea(
          child: Stack(
        children: [
          _pageList[_currentIndex],
          if (loading) const LoadingWidget(),
        ],
      )),
    );
  }
}
