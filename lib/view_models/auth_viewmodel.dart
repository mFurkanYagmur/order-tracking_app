import 'package:flutter/material.dart';
import 'package:order_tracking_app/repository/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _repository = AuthRepository.instance;

  Future login({required String email, required String password}) {
    return _repository.login(email, password);
  }

  Future<bool> checkLoginStatus() {
    return _repository.isLogged();
  }

  Future<bool> signOut() {
    return _repository.signOut();
  }
}