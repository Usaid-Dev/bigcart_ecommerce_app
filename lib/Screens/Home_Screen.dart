import 'package:badges/badges.dart';
import 'package:bigcart_ecommerce_app/Models/CategoryModel.dart';
import 'package:bigcart_ecommerce_app/Models/ProductModel.dart';
import 'package:bigcart_ecommerce_app/Providers/cart_provider.dart';
import 'package:bigcart_ecommerce_app/Providers/category_provider.dart';
import 'package:bigcart_ecommerce_app/Providers/product_provider.dart';
import 'package:bigcart_ecommerce_app/Providers/user_provider.dart';
import 'package:bigcart_ecommerce_app/Screens/Cart_Screen.dart';
import 'package:bigcart_ecommerce_app/Screens/Favorites_Screen.dart';
import 'package:bigcart_ecommerce_app/Screens/Login_Screen.dart';
import 'package:bigcart_ecommerce_app/Screens/ProductsByTitle_Screen.dart';
import 'package:bigcart_ecommerce_app/Widgets/categories_items.dart';
import 'package:bigcart_ecommerce_app/Widgets/product_card.dart';
import 'package:carousel_nullsafety/carousel_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Utility/shared_preference.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {

  @override
  Widget build(BuildContext context) {
    Category_Provider categoryProvider =
        Provider.of<Category_Provider>(context, listen: false);
    User_Provider userProvider =
        Provider.of<User_Provider>(context, listen: false);
    Product_Provider productProvider =
        Provider.of<Product_Provider>(context, listen: false);
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xffFFFFFF),
            Color(0xffFFFFFF),
            Color(0xffF4F5F9),
          ],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Container(
              margin: const EdgeInsets.only(left: 17, right: 17),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: const Color(0xffF4F5F9),
                  borderRadius: BorderRadius.circular(5)),
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: const Image(image: AssetImage('assets/images/search_icon.png')
                    ),
                    suffixIconColor: Colors.white,
                    hintText: "Search keywords...",
                    suffixIcon: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () {},
                        child: const Image(
                            image: AssetImage('assets/images/filter_icon.png')
                        ),
                      ),
                    ),
                    hintStyle: const TextStyle(
                        color: Color(0xFF868889),
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                    border: InputBorder.none),
                onSubmitted: (value) => onsearch(value),
              )
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Stack(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(left: 17, right: 17),
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width * 0.95,
                        child: const Carousel(
                          images: [
                            AssetImage('assets/images/homescreen_banner1.png'),
                            AssetImage('assets/images/homescreen_banner2.png'),
                            AssetImage('assets/images/homescreen_banner3.png'),
                            AssetImage('assets/images/homescreen_banner4.png'),
                            AssetImage('assets/images/homescreen_banner5.png'),
                          ],
                          dotSize: 6.0,
                          dotSpacing: 20.0,
                          dotColor: Colors.white,
                          dotIncreasedColor: Colors.green,
                          indicatorBgPadding: 15.0,
                          dotBgColor: Colors.transparent,
                          dotPosition: DotPosition.bottomLeft,
                          boxFit: BoxFit.cover,
                        )),
                    const Positioned(
                        top: 120,
                        left: 30,
                        child: Text("20% off on your \n first purchase",
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)
                        )
                    )
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width * 0.06,
                    ),
                    const Text("Categories",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)
                    ),
                    const Spacer(),
                    Material(
                        color: Colors.transparent,
                        child: InkWell(
                            onTap: () => {},
                            borderRadius: BorderRadius.circular(100),
                            child: const Icon(Icons.arrow_forward_ios)
                        )
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                  ],
                ),
                Container(
                    height: 100,
                    child: FutureBuilder(
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(
                                child: CircularProgressIndicator(
                                    color: Theme.of(context).primaryColorDark));
                          }
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              CategoryModel category = snapshot.data[index];
                              return categories_items(
                                  image: _replaceUrlPort(category.icon!),
                                  title: category.title!,
                                  catID: category.id!,
                                  color: _colorFromHex(category.color!));
                            },
                            itemCount:
                                categoryProvider.categorylist?.length ?? 0,
                          );
                        },
                        future: categoryProvider.getCategory(
                            userProvider.userModel.accessToken ?? "")
                    )
                ),
                Row(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.06,
                    ),
                    const Text("Featured products",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)
                    ),
                    const Spacer(),
                    Material(
                        color: Colors.transparent,
                        child: InkWell(
                            onTap: () => {},
                            borderRadius: BorderRadius.circular(100),
                            child: const Icon(Icons.arrow_forward_ios)
                        )
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                  ],
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: FutureBuilder(
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColorDark)
                  );
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
                  itemCount: productProvider.productlist?.length ?? 0,
                );
              },
              future: productProvider
                  .getAllProducts(userProvider.userModel.accessToken ?? ""),
            ),
          ),
          const SliverToBoxAdapter(
              child: SizedBox(
            height: 20,
          ))
        ]),
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
                    style: const TextStyle(fontWeight: FontWeight.w600)
                ),
              ),
              animationType: BadgeAnimationType.scale,
              showBadge: provider.cartProductList.isNotEmpty,
              badgeColor: const Color(0xFFFE585A),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const Cart_Screen()
                      )
                  );
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
                padding: const EdgeInsets.only(
                    top: 5, bottom: 5, left: 30, right: 10),
                child: IconButton(
                    icon: const Icon(Icons.logout_outlined,
                        color: Color(0xff868889)),
                    onPressed: () {
                      User_Perference().removeUserInfo().whenComplete(() {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const Login_Screen()
                            ),
                            (Route<dynamic> route) => false);
                      });
                    },
                    iconSize: 27),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5, left: 30, right: 10),
                child: IconButton(
                    icon: const Icon(Icons.home_outlined, color: Colors.black),
                    onPressed: () {},
                    iconSize: 27),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5, left: 30, right: 10),
                child: IconButton(
                    icon: const Icon(Icons.favorite_border,
                        color: Color(0xff868889)),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const Favorites_Screen()));
                    },
                    iconSize: 27),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      ),
    );
  }

  onsearch(String value) {
    if (value.isNotEmpty) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => ProductsByTitle_Screen(searchQuery: value)
      )
      );
    }
  }

  String _replaceUrlPort(String Url) {
    String newUrl = Url.replaceAll(":9001", ":2000");
    return newUrl;
  }

  Color _colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('ff$hexCode', radix: 16)).withOpacity(0.2);
  }
}
