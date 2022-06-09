import 'dart:ui';
import 'dart:convert';
class CartModel {
  int productId, categoryId, stock, qty;
  String title, image, unit;
  String color;
  double price;
  bool productAdded = false, productFavorite = false;


  CartModel({required this.productId,
       required this.categoryId,
      required this.stock,
      required this.qty,
      required this.title,
      required this.image,
      required this.unit,
      required this.price,
      required this.productAdded,
      required this.productFavorite,
      required this.color
      });


  fromJson(json){return CartModel(
  productId: json['productId'],
  categoryId: json['categoryId'],
  title: json['title'],
  stock: json['stock'],
  color: json['color'],
  image: json['image'],
  price: json['price'],
  qty: json['qty'],
  unit: json['unit'],
     productAdded: json['productAdded'],
     productFavorite: json['productFavorite']
  );}

  Map<String, dynamic> toJson() =>{
    "productId": productId,
    "categoryId":categoryId,
    "title": title,
    "stock": stock,
    "color": color.toString(),
    "image": image,
    "price": price,
    "qty": qty,
    "unit": unit,
    "productAdded":productAdded,
   "productFavorite":productFavorite
  };
}
