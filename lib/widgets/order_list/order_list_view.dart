import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:order_tracking_app/constants/extensions.dart';
import 'package:order_tracking_app/view_models/order_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../constants/style.dart';
import 'order_list_item.dart';

class OrderListView extends StatefulWidget {
  OrderListView({Key? key, required this.dateTime}) : super(key: key);

  DateTime dateTime;

  @override
  State<OrderListView> createState() => _OrderListViewState();
}

class _OrderListViewState extends State<OrderListView> {
  OrderViewModel? provider;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      await provider!.fetchOrderList(widget.dateTime.toFormattedString());
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    context.watch<OrderViewModel>();
    provider ??= context.read<OrderViewModel>();

    var orderList = provider!.orderList[widget.dateTime.toFormattedString()];

    if (orderList?.isEmpty ?? true) {
      return Center(child: Text('Listelenecek sipariş bulunamadı!'),);
    }
    return ListView.builder(
      itemCount: orderList?.length ?? 0,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: Style.defaultPadding * 0.2),
          child: OrderListItem(order: orderList![index]),
        );
      },
    );
  }
}
