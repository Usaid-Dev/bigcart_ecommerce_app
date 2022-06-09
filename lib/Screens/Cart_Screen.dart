import 'package:bigcart_ecommerce_app/Models/CartModel.dart';
import 'package:bigcart_ecommerce_app/Screens/Checkout_Screen.dart';
import 'package:bigcart_ecommerce_app/Widgets/cart_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../Providers/cart_provider.dart';
import '../Widgets/RaisedGradientButton.dart';

class Cart_Screen extends StatefulWidget {
  const Cart_Screen({Key? key}) : super(key: key);

  @override
  State<Cart_Screen> createState() => _Cart_ScreenState();
}

class _Cart_ScreenState extends State<Cart_Screen> {
  @override
  Widget build(BuildContext context) {
    double totalPrice = 0, shippingPrice = 1.5;
    return Scaffold(
      backgroundColor: const Color(0xffF4F5F9),
      appBar: AppBar(
        leading: Material(
            color: Colors.transparent,
            child: InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () => onback(context),
                child: const Icon(Icons.west, color: Colors.black))),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Shopping Cart"),
        titleTextStyle: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(child: Consumer<Cart_Provider>(
            builder: (context, provider, child) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  CartModel product = provider.cartProductList[index];
                  return Slidable(
                    key: UniqueKey(),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      dismissible: DismissiblePane(
                          onDismissed: () =>
                              ondelete_item(product.productId, provider)),
                      extentRatio: 0.25,
                      children: [
                        SlidableAction(
                          // An action can be bigger than the others.

                          backgroundColor: const Color(0xFFEF574B),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete Item',
                          onPressed: (BuildContext context) =>
                              ondelete_item(product.productId, provider),
                        ),
                      ],
                    ),
                    child: product.qty > 0
                        ? cart_item(
                            p_Id: product.productId,
                            imgPath: product.image,
                            p_Color: _colorFromHex(product.color),
                            p_Price: '\$ ${product.price}x${product.qty}',
                            p_Qty: '${product.stock} ${product.unit}',
                            p_Title: product.title,
                          )
                        : Container(),
                  );
                },
                itemCount: provider.cartProductList.length,
              );
            },
          ))
        ],
      ),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -15),
              blurRadius: 20,
              color: const Color(0xFFDADADA).withOpacity(0.15),
            )
          ],
        ),
        child: Consumer<Cart_Provider>(
          builder: (context, provider, child) {
            return Column(
              children: [
                const SizedBox(height: 22),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("Subtotal",
                        style: TextStyle(
                            color: Color(0xff868889),
                            fontWeight: FontWeight.w500,
                            fontSize: 15)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                    ),
                    Text("\$${provider.getProductsPrice()}",
                        style: const TextStyle(
                            color: Color(0xff868889),
                            fontWeight: FontWeight.w500,
                            fontSize: 15)),
                  ],
                ),
                const SizedBox(height: 7),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("Shipping charges",
                        style: TextStyle(
                            color: Color(0xff868889),
                            fontWeight: FontWeight.w500,
                            fontSize: 15)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.35,
                    ),
                    Text("\$$shippingPrice",
                        style: const TextStyle(
                            color: Color(0xff868889),
                            fontWeight: FontWeight.w500,
                            fontSize: 15)),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.all(20),
                    child:
                        Container(color: const Color(0xFFEBEBEB), height: 1.5)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text("Total",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                    ),
                    Text("\$${provider.getProductsPrice() + shippingPrice}",
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18)),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                RaisedGradientButton(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.9,
                  margin_left: 17,
                  margin_right: 17,
                  isdisabled: provider.cartProductList
                              .where((element) => element.qty > 0)
                              .length >=
                          1
                      ? false
                      : true,
                  child: const Text("Checkout",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 1)),
                  gradient: const LinearGradient(
                    colors: <Color>[Color(0xffAEDC81), Color(0xff6CC51D)],
                  ),
                  onPressed: () => oncheckout_press(),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  onback(BuildContext context) {
    Navigator.of(context).pop();
  }

  oncheckout_press() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const Checkout_Screen()));
  }

  ondelete_item(int productId, Cart_Provider provider) {
    provider.removeProduct(productId);
  }

  Color _colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('ff$hexCode', radix: 16)).withOpacity(0.2);
  }
}
