import 'dart:convert';
import 'dart:io';
import 'package:bigcart_ecommerce_app/Models/Api_Response.dart';
import 'package:bigcart_ecommerce_app/Models/CategoryModel.dart';
import 'package:bigcart_ecommerce_app/Utility/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Category_Provider extends ChangeNotifier{

   List<CategoryModel>? _categorylist;

  List<CategoryModel>? get categorylist => _categorylist;

  Future <List<CategoryModel>> getCategory(String accesstoken)async{

    Map<String, String> _tokendata = {

      'Authorization': 'Bearer $accesstoken'
    };
      var response = await http.get(Uri.parse(api_urls.getallcategories), headers: _tokendata);
      if (response.statusCode == 200) {
        var decodedjson = jsonDecode(response.body);
        List<dynamic> datalist =decodedjson['data'];
        _categorylist= datalist.map((e) => new CategoryModel.fromJson(e)).toList();
        notifyListeners();

      }
      else{
        var decodedjson = jsonDecode(response.body);
        print(decodedjson['message']);
      }

    return _categorylist!;
  }


}
