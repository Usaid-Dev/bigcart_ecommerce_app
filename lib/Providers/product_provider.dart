import 'dart:convert';

import 'package:bigcart_ecommerce_app/Models/ProductModel.dart';
import 'package:bigcart_ecommerce_app/Utility/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product_Provider extends ChangeNotifier{

  List<ProductModel>? _productlist;
  List<ProductModel>? get productlist => _productlist;


  Future <List<ProductModel>> getAllProducts(String accesstoken)async{

    Map<String, String> _tokendata = {

      'Authorization': 'Bearer $accesstoken'
    };
    var response = await http.get(Uri.parse(api_urls.getallproducts), headers: _tokendata);
    if (response.statusCode == 200) {
      var decodedjson = jsonDecode(response.body);

      List<dynamic> datalist =decodedjson['data'];
      _productlist= datalist.map((e) => new ProductModel.fromJson(e)).toList();
      notifyListeners();

    }
    else{
      _productlist = [];
      var decodedjson = jsonDecode(response.body);
      print(decodedjson['message']);
      notifyListeners();
    }

    return _productlist!;
  }

  Future <List<ProductModel>> getProductsWithCatId({required String accesstoken,required int CatId})async{

    Map<String, String> _tokendata = {
      'Authorization': 'Bearer $accesstoken'
    };

    var response = await http.get(Uri.parse(api_urls.getallproductsbycategoryid+CatId.toString()), headers: _tokendata);
    if (response.statusCode == 200) {
      var decodedjson = jsonDecode(response.body);

      List<dynamic> datalist =decodedjson['data'];
      _productlist= datalist.map((e) => new ProductModel.fromJson(e)).toList();
      notifyListeners();

    }
    else{
      _productlist = [];
      var decodedjson = jsonDecode(response.body);
      print(decodedjson['message']);
      notifyListeners();
    }

    return _productlist!;
  }

  Future <List<ProductModel>> searchProductsByTitle({required String accesstoken,required String title})async{

    Map<String, String> _tokendata = {

      'Authorization': 'Bearer $accesstoken'
    };

    var response = await http.get(Uri.parse(api_urls.getproductbytitle+title.toString()), headers: _tokendata);
    if (response.statusCode == 200) {
      var decodedjson = jsonDecode(response.body);

      List<dynamic> datalist =decodedjson['data'];
      _productlist= datalist.map((e) => new ProductModel.fromJson(e)).toList();
      notifyListeners();
    }
    else{
      _productlist=[];
      var decodedjson = jsonDecode(response.body);
      print(decodedjson['message']);
      notifyListeners();
    }

    return _productlist!;
  }



}