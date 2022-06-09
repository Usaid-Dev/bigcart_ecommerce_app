import 'dart:ffi';
import 'package:bigcart_ecommerce_app/Models/Api_DataModel.dart';

class ProductModel extends ApiDataModel{
  int? id,catId,stockAvailable,qty;
  String? title;
  String? unit;
  String? image;
  String? color;
  double? price;

  ProductModel(
      {this.id,
      this.catId,
      this.stockAvailable,
      this.qty,
      this.title,
      this.unit,
      this.image,
      this.color,
      this.price});


  factory ProductModel.fromJson(Map<String, dynamic> json) =>ProductModel(
   id: json['id'],
   catId: json['catId'],
   title: json['title'],
   stockAvailable: json['stockAvailable'],
   color: json['color'],
   image: json['image'],  
   price: json['price'],  
   qty: json['qty'],  
   unit: json['unit'],
  );

  @override
  Map<String, dynamic> toJson() =>{
    "id": id,
    "catId":catId,
    "title": title,
    "stockAvailable": stockAvailable,
    "color": color,
    "image": image,
    "price": price,
    "qty": qty,
    "unit": unit
  };

}