import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/ProductModel.dart';
import '../Providers/product_provider.dart';
import '../Providers/user_provider.dart';
import '../Widgets/product_card.dart';

class ProductsByTitle_Screen extends StatefulWidget {
  final String searchQuery;

  ProductsByTitle_Screen({required this.searchQuery});
  @override
  State<ProductsByTitle_Screen> createState() => _ProductsByTitle_ScreenState();
}

class _ProductsByTitle_ScreenState extends State<ProductsByTitle_Screen> {
  TextEditingController editingController = TextEditingController();
  String title = "";
  @override
  void initState() {
    super.initState();
    editingController.text = widget.searchQuery;
    title = widget.searchQuery;
  }

  @override
  Widget build(BuildContext context) {
    User_Provider userProvider =
        Provider.of<User_Provider>(context, listen: false);
    Product_Provider productProvider =
        Provider.of<Product_Provider>(context, listen: false);
    return Scaffold(
      backgroundColor: const Color(0xffF4F5F9),
      appBar: AppBar(
        title: Container(
            margin: const EdgeInsets.only(left: 17, right: 17),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: const Color(0xffF4F5F9),
                borderRadius: BorderRadius.circular(5)),
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: const Image(
                      image: const AssetImage('assets/images/search_icon.png')),
                  suffixIconColor: Colors.white,
                  hintText: "Search keywords...",
                  suffixIcon: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () {},
                      child: const Image(
                          image: AssetImage('assets/images/filter_icon.png')),
                    ),
                  ),
                  hintStyle: const TextStyle(
                      color: Color(0xFF868889),
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                  border: InputBorder.none),
              onChanged: (value) {
                setState(() {
                  title = value;
                });
              },
              onSubmitted: (value) {
                setState(() {
                  title = value;
                });
              },
              controller: editingController,
            )),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColorDark));
                  }
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                    itemCount: productProvider.productlist?.length ?? 0,
                  );
                },
                future: productProvider.searchProductsByTitle(
                    accesstoken: userProvider.userModel.accessToken ?? "",
                    title: title)),
          )
        ],
      ),
    );
  }

  onsearch(String value) {}
}
