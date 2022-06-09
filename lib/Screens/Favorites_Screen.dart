import 'package:badges/badges.dart';
import 'package:bigcart_ecommerce_app/Screens/Home_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../Models/CartModel.dart';
import '../Providers/cart_provider.dart';
import '../Utility/shared_preference.dart';
import '../Widgets/cart_item.dart';
import 'Cart_Screen.dart';
import 'Login_Screen.dart';

class Favorites_Screen extends StatelessWidget {
  const Favorites_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        title: const Text("Favorites"),
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
                    child: product.productFavorite
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
      floatingActionButton: Consumer<Cart_Provider>(
        builder: (context, provider, child) {
          return Badge(
            badgeContent: Padding(
              padding: const EdgeInsets.all(1.5),
              child: Text(
                  provider.cartProductList
                      .where((element) => element.qty > 0)
                      .length
                      .toString(),
                  style: const TextStyle(fontWeight: FontWeight.w600)),
            ),
            animationType: BadgeAnimationType.scale,
            showBadge: provider.cartProductList.isNotEmpty,
            badgeColor: const Color(0xFFFE585A),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const Cart_Screen()));
              },
              backgroundColor: Theme.of(context).primaryColorDark,
              elevation: 10,
              child: const Icon(Icons.shopping_bag_outlined),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(), //shape of notch
        notchMargin: 5,
        child: Row(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 5, bottom: 5, left: 30, right: 10),
              child: IconButton(
                  icon: const Icon(Icons.logout_outlined,
                      color: Color(0xff868889)),
                  onPressed: () {
                    User_Perference().removeUserInfo().whenComplete(() {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const Login_Screen()),
                          (Route<dynamic> route) => false);
                    });
                  },
                  iconSize: 27),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 5, bottom: 5, left: 30, right: 10),
              child: IconButton(
                  icon: const Icon(Icons.home_outlined,
                      color: const Color(0xff868889)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  iconSize: 27),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 5, bottom: 5, left: 30, right: 10),
              child: IconButton(
                  icon: const Icon(Icons.favorite_border, color: Colors.black),
                  onPressed: () {},
                  iconSize: 27),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  onback(BuildContext context) {
    Navigator.of(context).pop();
  }

  ondelete_item(int productId, Cart_Provider provider) {
    provider.removeProduct(productId);
  }

  Color _colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('ff$hexCode', radix: 16)).withOpacity(0.2);
  }
}
