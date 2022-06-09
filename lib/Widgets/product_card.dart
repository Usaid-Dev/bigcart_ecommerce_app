import 'dart:ffi';
import 'dart:ui';

import 'package:bigcart_ecommerce_app/Models/CartModel.dart';
import 'package:bigcart_ecommerce_app/Models/ProductModel.dart';
import 'package:bigcart_ecommerce_app/Providers/cart_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/product_provider.dart';

class product_card extends StatefulWidget {
  final String title, imgPath, unit;
  final double price;
  final String color;
  final int productId, categoryId, stock, qyt;

  product_card(
      {required this.title,
      required this.imgPath,
      required this.unit,
      required this.price,
      required this.color,
      required this.productId,
      required this.categoryId,
      required this.stock,
      required this.qyt});

  @override
  State<product_card> createState() => _product_cardState();
}

class _product_cardState extends State<product_card> {
  @override
  Widget build(BuildContext context) {
    Cart_Provider cartProvider =
        Provider.of<Cart_Provider>(context, listen: false);
    return Padding(
        padding: EdgeInsets.only(top: 20, left: 10, right: 10),
        child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3.0,
                  blurRadius: 5.0)
            ], color: Colors.white),
            child: Column(children: [
              Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Consumer<Cart_Provider>(builder: (context, provider, child) {
                  return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    provider.isProductFavorite(widget.productId) ? Material(
                            color: Colors.transparent,
                            child: InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: () {provider.removeFromFavorite(widget.productId);},
                                child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Icon(Icons.favorite,
                                        color: Color(0xFFFE585A)))))
                        : Material(
                            color: Colors.transparent,
                            child: InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: () {provider.addToFavorite(id: widget.productId,
                                  cartModel: CartModel(
                                      productId: widget.productId,
                                      categoryId: widget.categoryId,
                                      stock: widget.stock,
                                      qty: 0,
                                      title: widget.title,
                                      image: widget.imgPath,
                                      unit: widget.unit,
                                      price: widget.price,
                                      color: widget.color,
                                      productAdded: false,
                                      productFavorite: true)
                                );},
                                child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Icon(Icons.favorite_border,
                                        color: Color(0xFF868889)))))
                  ]);
  },
)),
              Hero(
                  tag: widget.imgPath,
                  child: Container(
                    height: 84,
                    width: 84,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: _colorFromHex(widget.color)),
                    child: Image.network(widget.imgPath, width: 26, height: 26,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                      return const Text('no image');
                    }, alignment: Alignment.bottomCenter),
                  )),
              SizedBox(height: 8.0),
              Text("\$ ${widget.price}",
                  style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontWeight: FontWeight.w500,
                      fontSize: 12)),
              Text(widget.title,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
              Text("doze",
                  style: TextStyle(
                      color: Color(0xff868889),
                      fontWeight: FontWeight.w500,
                      fontSize: 12)),
              Padding(
                  padding: EdgeInsets.only(top: 4, bottom: 4),
                  child: Container(color: Color(0xFFEBEBEB), height: 1.0)),
              Padding(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Consumer<Cart_Provider>(
                    builder: (context, provider, child) {
                      return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (provider.isProductAdded(widget.productId) == false) ...[
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: () {
                                    cartProvider.addProductToCart(CartModel(
                                        productId: widget.productId,
                                        categoryId: widget.categoryId,
                                        stock: widget.stock,
                                        qty: 1,
                                        title: widget.title,
                                        image: widget.imgPath,
                                        unit: widget.unit,
                                        price: widget.price,
                                        productAdded: true,
                                        productFavorite: false,
                                        color: widget.color));
                                    cartProvider.cartProductList
                                        .forEach((element) {
                                      print(
                                          "${element.title} ${element.qty}  ${element.productId} ");
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 1, left: 5, right: 5),
                                    child: Row(
                                      children: [
                                        Icon(Icons.shopping_bag_outlined,
                                            color: Theme.of(context)
                                                .primaryColorDark),
                                        SizedBox(width: 9),
                                        Text('Add to cart',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff010101),
                                                fontSize: 12))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                            if (provider.isProductAdded(widget.productId) == true) ...[
                              SizedBox(height: 30),
                              Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                      borderRadius: BorderRadius.circular(20),
                                      onTap: () {
                                        cartProvider.decrementProductQyt(widget.productId);
                                      },
                                      child: Icon(Icons.remove_outlined,
                                          color: Theme.of(context)
                                              .primaryColorDark))),
                              SizedBox(width: 40),
                              Text(
                                  '${provider.getProductQyt(widget.productId)}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff010101),
                                      fontSize: 12)),
                              SizedBox(width: 40),
                              Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                      borderRadius: BorderRadius.circular(20),
                                      onTap: () {
                                        cartProvider.incrementProductQyt(
                                            widget.productId);
                                      },
                                      child: Icon(Icons.add_outlined,
                                          color: Theme.of(context)
                                              .primaryColorDark))),
                            ]

                          ]);
                    },
                  ))
            ])));
  }
  Color _colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('ff$hexCode', radix: 16)).withOpacity(0.2);
  }
}
