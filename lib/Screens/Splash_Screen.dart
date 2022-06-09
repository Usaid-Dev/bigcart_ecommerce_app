import 'dart:async';
import 'package:bigcart_ecommerce_app/Models/UserModel.dart';
import 'package:bigcart_ecommerce_app/Screens/Home_Screen.dart';
import 'package:bigcart_ecommerce_app/Screens/Login_Screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Providers/cart_provider.dart';
import '../Providers/user_provider.dart';
import '../Utility/shared_preference.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({Key? key}) : super(key: key);

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  @override
  void initState() {
    super.initState();
    User_Perference().getUserInfo().then((value) {
      if (value.accessToken != null) {
        Provider.of<User_Provider>(context, listen: false).setUser(value);
        Provider.of<Cart_Provider>(context, listen: false).getCartListLoaded();
        Future.delayed(const Duration(seconds: 5),
            () => nav_screen(context, const Home_Screen()));
      } else {
        Future.delayed(const Duration(seconds: 5),
            () => nav_screen(context, const Login_Screen()));
      }
    }).onError((error, stackTrace) {
      throw error.toString();
    });
    Future.delayed(const Duration(seconds: 5), () => const Login_Screen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
              child: FittedBox(
            fit: BoxFit.cover,
            child: Image.asset('assets/images/splash_img.png'),
          )),
          Positioned(
            child: Column(
              children: [
                const SizedBox(height: 96),
                const Align(
                  alignment: Alignment.center,
                  child: Text("Welcome to",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 30)),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset('assets/images/bigcart_splash_logo.png'),
                ),
                const SizedBox(height: 17),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                      "Lorem ipsum dolor sit amet, consetetur \n \t \t sadipscing elitr, sed diam nonumy",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Color(0xff868889))),
                ),
                const Spacer(),
                Center(
                    child: CircularProgressIndicator(
                        strokeWidth: 10,
                        color: Theme.of(context).primaryColorDark)),
                const SizedBox(height: 50),
                const Align(
                  alignment: Alignment.center,
                  child: Text("POWERED BY",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          letterSpacing: 7,
                          color: Color(0xff868889))),
                ),
                const SizedBox(height: 6),
                Align(
                  alignment: Alignment.center,
                  child: Text("TECH IDARA",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          letterSpacing: 8,
                          wordSpacing: 8,
                          color: Theme.of(context).primaryColorDark)),
                ),
                const SizedBox(height: 20),
              ],
            ),
          )
        ],
      ),
    );
  }

  nav_screen(BuildContext context, Widget screen) => Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => screen));
}
