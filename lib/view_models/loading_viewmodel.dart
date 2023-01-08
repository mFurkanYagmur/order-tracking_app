import 'package:flutter/material.dart';

class LoadingViewModel extends ChangeNotifier {
  bool loading = false;

  void start() {
    loading = true;
    notifyListeners();
  }

  void end() {
    loading = false;
    notifyListeners();
  }
}