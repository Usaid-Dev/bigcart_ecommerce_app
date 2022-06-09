import 'package:bigcart_ecommerce_app/Models/Api_DataModel.dart';

class Api_Response<T extends ApiDataModel> {
  String? message;
  int? statusCode;
  T? data;
  Api_Response({this.message, this.statusCode, this.data});

  Api_Response.fromJson(Map<String, dynamic> json, T responsedata)
  {
    message = json['message'];
    statusCode = json['statusCode'];
    data =responsedata;
  }
  Map<String,dynamic>toJson(){
    return{
      "message":message,
      "statusCode":statusCode,
      "data":data?.toJson()
    };
  }

}