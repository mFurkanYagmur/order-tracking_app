import 'dart:core';

class OrderStatus {
  final currentStatus;

  OrderStatus(this.currentStatus);

  static const int olcuBekleniyor = 0, islemSirasinda = 1, dikilecek = 2, hazir = 3, teslimEdildi = 4;

  static const List<int> values = [
    olcuBekleniyor,
    islemSirasinda,
    dikilecek,
    hazir,
    teslimEdildi,
  ];
}

class OrderModel {
  String? orderNumber;
  String? customerName;
  double? price;
  double? paid;
  String? description;
  String? customerPhone;
  String? imageUrl;
  String? email;
  DateTime? uploadDate;
  DateTime? deliverDate;
  DateTime? lastChangedDate;
  String? documentId;
  OrderStatus? orderStatus;

  OrderModel({
    this.orderNumber,
    this.customerName,
    this.price,
    this.paid,
    this.description,
    this.customerPhone,
    this.imageUrl,
    this.email,
    this.uploadDate,
    this.deliverDate,
    this.lastChangedDate,
    this.documentId,
    this.orderStatus,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        orderNumber: json["order_number"],
        customerName: json["customer_name"],
        price: json["price"],
        paid: json["paid"],
        description: json["description"],
        customerPhone: json["customer_phone"],
    imageUrl: json["image_url"],
        email: json["email"],
        uploadDate: json["upload_date"],
        deliverDate: json["deliver_date"],
        lastChangedDate: json["last_changed_date"],
        documentId: json["documentId"],
        orderStatus: json["orderStatus"],
      );

  Map<String, dynamic> toJson() => {
        "order_number": orderNumber,
        "customer_name": customerName,
        "price": price,
        "paid": paid,
        "description": description,
        "customer_phone": customerPhone,
        "image_url": imageUrl,
        "email": email,
        "upload_date": uploadDate,
        "deliver_date": deliverDate,
        "last_changed_date": lastChangedDate,
        "documentId": documentId,
        "orderStatus": orderStatus,
      };
}
