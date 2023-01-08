import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:order_tracking_app/constants/style.dart';
import 'package:order_tracking_app/view_models/order_viewmodel.dart';
import 'package:order_tracking_app/widgets/order_list/order_list_view.dart';
import 'package:provider/provider.dart';

part 'components/_search_page_search_input.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _buildAppBar(context),
        OrderListView(dateTime: DateTime.now()),
      ],
    );
  }

  Card _buildAppBar(BuildContext context) {
    double cardHeight = 0.15.sw;
    return Card(
      margin: EdgeInsets.all(Style.defaultPadding),
      shape: StadiumBorder(side: BorderSide(color: Theme.of(context).shadowColor, width: 1, strokeAlign: StrokeAlign.inside)),
      clipBehavior: Clip.antiAlias,
      color: Style.primaryColor,
      child: Container(
        width: double.infinity,
        height: 0.15.sw,
        padding: EdgeInsets.zero,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10000),
              ),
              child: SizedBox(
                  height: cardHeight,
                  width: cardHeight,
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.sort,
                        size: Style.defaultIconSize * 0.75,
                      ))),),
            const Spacer(),
            _SearchPageSearchInput(cardHeight: cardHeight),
          ],
        ),
      ),
    );
  }
}
