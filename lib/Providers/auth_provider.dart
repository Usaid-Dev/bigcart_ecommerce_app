import 'dart:convert';
import 'dart:io';
import 'package:bigcart_ecommerce_app/Models/Api_Response.dart';
import 'package:bigcart_ecommerce_app/Models/UserModel.dart';
import 'package:bigcart_ecommerce_app/Utility/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bigcart_ecommerce_app/Utility/api_urls.dart';

class Auth_Provider extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool _isSignedup = false;
  bool _isLoading = false;
  bool _isRemember =false;
  String? _message;

  bool get isRemember => _isRemember;
  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;

  set isRemember(bool value) {
    _isRemember = value;
  }
  Future<Map<String, dynamic>> getUserLoggedIn(String emailaddress, String password) async {

    Map<String, dynamic> result;
    Map<String, dynamic> _loginData = {

      'email': emailaddress,
      'password': password
    };
    print(_loginData);

    _isLoading = true;

    notifyListeners();

    try {
      var response = await http.post(Uri.parse(api_urls.signin), body: _loginData);
      if (response.statusCode == 200) {
        var decodedjson = jsonDecode(response.body);
        UserModel user = UserModel.fromJson(decodedjson['data']);
        var apiresponse = Api_Response.fromJson(decodedjson, user);
      
        if(isRemember)
          {
            User_Perference().saveUserInfo(user);
          }
        _isLoading = false;
        _isLoggedIn = true;
        _message = apiresponse.message;
        notifyListeners();
        return result = {
          "Isloggedin": _isLoggedIn,
          "Message": _message,
          "User":user
        };
      } else if (response.statusCode == 404) {
        var decodedjson = jsonDecode(response.body);
        _isLoading = false;
        _isLoggedIn = false;
        _message = decodedjson['message'];
        notifyListeners();
        return result = {
          "Isloggedin": _isLoggedIn,
          "Message": _message,
        };
      } else {
        var decodedjson = jsonDecode(response.body);
        _isLoading = false;
        _isLoggedIn = false;
        _message = decodedjson['message'];
        notifyListeners();
        return result = {
          "Isloggedin": _isLoggedIn,
          "Message": _message,
        };
      }
    } on SocketException catch (e) {
      print(e.message);
      _isLoading = false;
      _isLoggedIn = false;
      notifyListeners();
      return result = {
        "Isloggedin": _isLoggedIn,
        "Message": "Unable to reach the internet! Please try again in a moment.",
      };
    }
    catch(e){
      print(e.toString());
      _isLoading = false;
      _isLoggedIn = false;
      notifyListeners();
      return result = {
        "Isloggedin": _isLoggedIn,
        "Message": "Something went wrong! Please try again in a moment!",
      };
    }

  }


  Future<Map<String, dynamic>> getUserSignedUp(String emailaddress,String phone, String password) async {

    Map<String, dynamic> result;
    Map<String, dynamic> signupdata = {

      'email': emailaddress,
      'phone': phone,
      'password': password
    };

    print(signupdata);

    _isLoading = true;
    notifyListeners();

    try {
      var response = await http.post(Uri.parse(api_urls.signup), body: signupdata);
      if (response.statusCode == 200) {
        var decodedjson = jsonDecode(response.body);
        UserModel user = UserModel.fromJson(decodedjson['data']);
        var apiresponse = Api_Response.fromJson(decodedjson, user);
        User_Perference().saveUserInfo(user);

        _isLoading = false;
        _isSignedup = true;
        _message = apiresponse.message;
        notifyListeners();
        return result = {
          "isSignedup": _isSignedup,
          "Message": _message,
          "User":user
        };
      } else {
        var decodedjson = jsonDecode(response.body);
        _isLoading = false;
        _isSignedup = false;
        _message = decodedjson['message'];
        notifyListeners();
        return result = {
          "isSignedup": _isSignedup,
          "Message": _message,
        };
      }
    } on SocketException catch (e) {
      print(e.message);
      return result = {
        "isSignedup": false,
        "Message": "Unable to reach the internet! Please try again in a moment.",
      };
    }
    catch(e){
      print(e);
      return result = {
        "isSignedup": false,
        "Message": "Something went wrong! Please try again in a moment!",
      };
    }

  }

}
