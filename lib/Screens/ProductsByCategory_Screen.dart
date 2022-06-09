import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Models/ProductModel.dart';
import '../Providers/product_provider.dart';
import '../Providers/user_provider.dart';
import '../Widgets/custom_textfield.dart';
import '../Widgets/product_card.dart';

class Filtered_Products_Screen extends StatefulWidget {
  final int catId;
  final String catName;
  const Filtered_Products_Screen({required this.catId, required this.catName});
  @override
  State<Filtered_Products_Screen> createState() =>
      _Filtered_Products_ScreenState();
}

class _Filtered_Products_ScreenState extends State<Filtered_Products_Screen> {
  @override
  Widget build(BuildContext context) {
    User_Provider userProvider =
        Provider.of<User_Provider>(context, listen: false);
    Product_Provider productProvider =
        Provider.of<Product_Provider>(context, listen: false);
    //productProvider.productlist?.forEach((element) {print("${element.title} ${element.qty} ");});
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
        automaticallyImplyLeading: false,
        title: Text(widget.catName),
        titleTextStyle: const TextStyle(
            letterSpacing: 1,
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 18),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Material(
                color: Colors.transparent,
                child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {},
                    child: const Icon(Icons.tune, color: Colors.black))),
          ),
        ],
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColorDark));
                }
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.8),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (BuildContext context, int index) {
                    ProductModel product = snapshot.data[index];
                    return product_card(
                        title: product.title!,
                        price: product.price!,
                        imgPath: product.image!,
                        color: product.color!,
                        categoryId: product.catId!,
                        productId: product.id!,
                        qyt: product.qty ?? 0,
                        stock: product.stockAvailable!,
                        unit: product.unit ?? "");
                  },
                  itemCount: productProvider.productlist?.length,
                );
              },
              future: productProvider.getProductsWithCatId(
                  accesstoken: userProvider.userModel.accessToken ?? "",
                  CatId: widget.catId),
            ),
          )
        ],
      ),
    );
  }

  onback(BuildContext context) {
    Navigator.of(context).pop();
  }

  onsearch() {}
}
