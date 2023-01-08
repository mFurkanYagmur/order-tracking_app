import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:order_tracking_app/model/add_order_model.dart';
import 'package:order_tracking_app/model/order_model.dart';

class FirebaseClient {
  FirebaseClient._();

  static FirebaseClient? _instance;

  static FirebaseClient get instance {
    _instance ??= FirebaseClient._();
    return _instance!;
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> login(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user!.email!;
    } catch (e) {
      rethrow;
    }
  }

  Future signOut() async {
    try {
      return _firebaseAuth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  Future saveOrder(AddOrderModel orderModel) async {
    Map<String, dynamic> data = orderModel.toJson();
    data['created_date'] = Timestamp.now();
    formatRecordData(data);
    File? image = data.remove('image');

    //  TODO: firebase transaction yapısı eklenebilir

    var documentReference = await _firestore.collection('orders').add(data);
    if (image != null) {
      var putFileResult = await _storage.ref().child('order_images/${documentReference.id}').putFile(image);
      String imageDownloadUrl = await putFileResult.ref.getDownloadURL();
      await documentReference.update({'image_url': imageDownloadUrl});
    }
    log('New order is saved! path:"${documentReference.path}"', name: 'FirebaseClient-saveOrder');
  }

  Future<List<OrderModel>> fetchOrderList({required String? searchKeyword}) async {
    var result = await _firestore.collection('orders').orderBy('deliver_date', descending: false).get();
    var list =  result.docs
        .map((e) => OrderModel.fromJson(
              formatModelData(e.data()),
            ))
        .toList();
    return list;
  }

  /// veritabanına uygun formata döndürür
  formatRecordData(Map<String, dynamic> data) {
    for (var entry in data.entries) {
      if (entry.value is DateTime) {
        data[entry.key] = Timestamp.fromDate(entry.value);
      }
    }
  }

  /// programda kullanılan model formatına döndürür
  Map<String, dynamic> formatModelData(Map<String, dynamic> data) {
    for (var entry in data.entries) {
      if (entry.value is Timestamp) {
        data[entry.key] = (entry.value as Timestamp).toDate();
      }
    }
    return data;
  }
}
