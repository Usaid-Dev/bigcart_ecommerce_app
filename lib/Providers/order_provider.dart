import 'dart:convert';
import 'dart:io';
import 'package:bigcart_ecommerce_app/Utility/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Models/OrderModel.dart';

class Order_Provider extends ChangeNotifier {

  late OrderModel data;
  Future<Map<String, dynamic>> placeOrder({required OrderModel orderModel ,required String accessToken}) async {
    Map<String, dynamic> result={};
    Map<String, String> _tokendata = {
      'Authorization': 'Bearer $accessToken',
      "Content-Type": "application/json"
    };

      var response = await http.post(Uri.parse(api_urls.createorder),headers: _tokendata, body: jsonEncode(orderModel.toJson()));

      try {
        if(response.statusCode == 200) {
            var decodedjson = jsonDecode(response.body);
            /*print("Success message :  ${decodedjson['message']}");
            print("response body :  ${decodedjson.toString()}");*/
            data = OrderModel.fromJson(decodedjson['data']);
            notifyListeners();
            result = {
              "IsOrderPlaced":true,
              "OrderResponse":decodedjson.toString(),
              "Message": "Your Order Is Successfully Placed."
            };
          }
        else {
          var decodedjson = jsonDecode(response.body);
          /*print("StatusCode:  ${response.statusCode}");
          print("Error message:  ${decodedjson['message']}");*/
          result = {
            "IsOrderPlaced":false,
            "Message": "${decodedjson['message']}"
          };
        }
      } on SocketException catch (e) {
        print("Execption on Socketexception:  $e");
        result = {
          "IsOrderPlaced":false,
          "Message": "Unable to reach the internet! Please try again in a moment.",
        };
      }
      catch(e){
        print("Exception on Catch:  $e");
        result = {
          "IsOrderPlaced":false,
          "Message": "Something went wrong! Please try again in a moment!",
        };
      }

    return result;
  }


}
