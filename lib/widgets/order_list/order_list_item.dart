import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../constants/style.dart';
import '../../model/order_model.dart';

class OrderListItem extends StatelessWidget {
  OrderListItem({Key? key, required this.order}) : super(key: key);

  final OrderModel order;
  final cardHeight = 300.h;

  @override
  Widget build(BuildContext context) {
    final cardRadius = BorderRadius.circular(Style.defaultRadiusSize*0.5);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: cardRadius,
      ),
      elevation: 20.0,
      child: Container(
        height: cardHeight,
        width: double.infinity,
        padding: EdgeInsets.all(cardHeight*0.05),
        child: Row(
          children: [
            _buildImage(cardRadius, cardHeight*0.9),
            SizedBox(width: Style.defaultPadding*0.5,),
            Expanded(
              child: _buildContent(context),
            )
          ],
        ),
      ),
    );
  }

  Column _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                order.customerName ?? '',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: Style.defaultPadding*0.2,),
              Expanded(
                child: Text(
                  order.description ?? '',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).disabledColor
                  ),
                ),
              ),
              SizedBox(height: Style.defaultPadding*0.2,),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(order.deliverDate != null
                    ? DateFormat('d MMMM').format(order.deliverDate!)
                    : '', style: Theme.of(context).textTheme.bodyMedium,),
              ),
            ],
          );
  }

  Container _buildImage(BorderRadius cardRadius, double size) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        borderRadius: cardRadius,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: ((order.imageUrl == null) ? const AssetImage('assets/images/notfound.png') : NetworkImage(order.imageUrl!)) as ImageProvider,
        ),
      ),
    );
  }
}
