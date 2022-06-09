import 'dart:convert';
import 'dart:ffi';

import 'package:bigcart_ecommerce_app/Models/UserModel.dart';
import 'package:bigcart_ecommerce_app/Providers/cart_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/CartModel.dart';

class User_Perference{

  saveUserInfo(UserModel userModel) async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (userModel.id != null) {
      sharedPreferences.setBool("IsUserLoggedIn", true);
      sharedPreferences.setInt('id', userModel.id!);
      sharedPreferences.setString('email', userModel.email!);
      sharedPreferences.setString('password', userModel.password!);
      sharedPreferences.setString('phone', userModel.phone!);
      sharedPreferences.setString('accessToken', userModel.accessToken!);
    }
  }

  saveCartItems(List<CartModel> cartList)async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List items = cartList.map((e) => e.toJson()).toList();
    sharedPreferences.setString("CartList", jsonEncode(items));
  }

  void removeCartItems() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey("CartList")) {
      sharedPreferences.remove('CartList');
    }
  }

  Future<List<CartModel>> getCartItems() async{
    List<CartModel> cartList=[];
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey("CartList")) {
      try {
        String? cartString = sharedPreferences.getString('CartList');
        List jsonlist = jsonDecode(cartString??"");
        for (var todo in jsonlist) {
            cartList.add(
                CartModel(
                    productId: todo['productId'],
                    categoryId: todo['categoryId'],
                    title: todo['title'],
                    stock: todo['stock'],
                    color: todo['color'],
                    image: todo['image'],
                    price: todo['price'],
                    qty: todo['qty'],
                    unit: todo['unit'],
                    productAdded: todo['productAdded'],
                    productFavorite: todo['productFavorite']
                )
            );
        }
      } catch (e) {
        print(e.toString());
      }
    }
    return cartList;
  }

  Future<UserModel> getUserInfo() async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int? id=sharedPreferences.getInt('id');
    String? email=sharedPreferences.getString('email');
    String? phone=sharedPreferences.getString('password');
    String? password=sharedPreferences.getString('phone');
    String? accessToken=sharedPreferences.getString('accessToken');

    return UserModel(
      id: id,
      email: email,
      password: password,
      phone: phone,
      accessToken: accessToken
    );
  }

  Future<bool> checkUserStatus() async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.containsKey("IsUserLoggedIn"))
      {
       return sharedPreferences.getBool("IsUserLoggedIn")!;
      }
    return false;
  }

  Future<String> getUserAccessToken() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? accessToken;
    if(sharedPreferences.containsKey("accessToken"))
    {
      accessToken = sharedPreferences.getString("accessToken");
    }
    return accessToken!;
  }

  Future removeUserInfo() async {

    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("IsUserLoggedIn", false);

    sharedPreferences.remove('id');
    sharedPreferences.remove('email');
    sharedPreferences.remove('phone');
    sharedPreferences.remove('password');
    sharedPreferences.remove('accessToken');

  }


}