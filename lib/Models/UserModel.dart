import 'package:bigcart_ecommerce_app/Models/Api_DataModel.dart';

class UserModel implements ApiDataModel{
  int? id;
  String? email;
  String? phone;
  String? password;
  String? accessToken;

  UserModel({this.id, this.email, this.phone, this.password, this.accessToken});

  @override
  Map<String, dynamic> toJson() =>{
      "id": id,
      "email": email,
      "phone": phone,
      "password": password,
      "accessToken": accessToken,
  };

  UserModel.fromJson(Map<String,dynamic> json)
  {
    id =json['id'];
    email =json['email'];
    phone =json['phone'];
    password =json['password'];
    accessToken =json['accessToken'];
  }

}