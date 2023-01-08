import 'package:order_tracking_app/data/firebase_client.dart';
import 'package:order_tracking_app/model/order_model.dart';

import '../model/add_order_model.dart';

class OrderRepository {
  OrderRepository._();

  static OrderRepository? _instance;

  static OrderRepository get instance {
    _instance ??= OrderRepository._();
    return _instance!;
  }

  final FirebaseClient _firebaseClient = FirebaseClient.instance;

  Future saveOrder(AddOrderModel orderModel) async {
    return await _firebaseClient.saveOrder(orderModel);
  }

  Future<List<OrderModel>> fetchOrderList({String? searchKeyword}) async {
    return await _firebaseClient.fetchOrderList(searchKeyword: searchKeyword);
  }
}
