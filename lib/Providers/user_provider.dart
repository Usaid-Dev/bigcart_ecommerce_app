import 'package:bigcart_ecommerce_app/Models/UserModel.dart';
import 'package:flutter/material.dart';
class User_Provider extends ChangeNotifier{
  UserModel _userModel = UserModel();

  UserModel get userModel => _userModel;

  void setUser (UserModel value) {
    _userModel = value;
    notifyListeners();
  }
}