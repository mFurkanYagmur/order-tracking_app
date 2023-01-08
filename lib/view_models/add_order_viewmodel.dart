import 'package:flutter/material.dart';
import 'package:order_tracking_app/model/add_order_model.dart';

import '../repository/order_repository.dart';

class AddOrderViewModel extends ChangeNotifier {
  final OrderRepository _repository = OrderRepository.instance;

  AddOrderModel orderModel = AddOrderModel();

  Future save() async {
    return await _repository.saveOrder(orderModel);
  }
}
