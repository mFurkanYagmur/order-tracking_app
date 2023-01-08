import 'dart:io';

class AddOrderModel {
  AddOrderModel();

  File? image;
  late String name;
  String? phone;
  late double price;
  double? paid;
  late String description;
  late DateTime deliverDate;
  DateTime? lastUpdateDate;

  Map<String, dynamic> toJson() => {
    'image': image,
    'customer_name': name,
    if (phone != null) 'customer_phone': phone,
    'price': price,
    if (paid != null) 'paid': paid,
    'description': description,
    'deliver_date': deliverDate,
    'lastUpdate_date': lastUpdateDate,
  };
}