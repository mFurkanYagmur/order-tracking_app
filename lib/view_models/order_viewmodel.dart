import 'package:flutter/cupertino.dart';
import 'package:order_tracking_app/constants/extensions.dart';

import '../model/order_model.dart';
import '../repository/order_repository.dart';

class OrderViewModel extends ChangeNotifier {
  final OrderRepository _repository = OrderRepository.instance;

  final Map<String, List<OrderModel>> _orderList = {};

  String? searchString;
  DateTime? filterDate;


  Map<String, List<OrderModel>> get orderList => _orderList;

  clearOrderList(){
    _orderList.clear();
    notifyListeners();
  }

  setOrderList(String date, List<OrderModel> orderList) {
    _orderList[date] = orderList;
    notifyListeners();
  }

  fetchOrderList([String? date]) async {
    _orderList[date ?? DateTime.now().toFormattedString()] = await _repository.fetchOrderList(searchKeyword: searchString);
    notifyListeners();
  }
}