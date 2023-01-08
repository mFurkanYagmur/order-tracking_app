import 'dart:collection';

import 'package:order_tracking_app/model/order_model.dart';

class DailyOrderMap extends MapBase<DateTime, List<OrderModel>>{
  Map<DateTime, List<OrderModel>> _map = {};

  @override
  List<OrderModel>? operator [](Object? key) {
    if (key !is DateTime) return null;
    DateTime dateTime = key as DateTime;
    // for (var entry in _map.entries) {
    //   if (entry.key.)
    // }
    return _map[DateTime(dateTime.year, dateTime.month, dateTime.day)];
  }

  @override
  void operator []=(DateTime key, List<OrderModel> value) {

    _map[key] = value;
  }

  @override
  void clear() {
    _map.clear();
  }

  @override
  Iterable<DateTime> get keys => _map.keys;

  @override
  List<OrderModel>? remove(Object? key) {
    return _map.remove(key);
  }

}