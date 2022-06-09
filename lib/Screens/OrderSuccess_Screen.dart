import 'package:bigcart_ecommerce_app/Screens/Home_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../Providers/order_provider.dart';
import '../Widgets/RaisedGradientButton.dart';

class OrderSuccess_Screen extends StatelessWidget {
  const OrderSuccess_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Order_Provider orderProvider = Provider.of<Order_Provider>(context, listen: false);
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: FittedBox(
                fit: BoxFit.contain,
                child: Image.asset('assets/images/success_icon.png'),
              ),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.045),
        const Text("Congrats!",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xff282828),
                fontSize: 24)),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        Consumer<Order_Provider>(
          builder: (context, provider, child) {
            return Text(
              "Your Order #${provider.data.orderId} is \n Successfully Received",
              style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Color(0xffB1B1B1),
                  fontSize: 16),
              textAlign: TextAlign.center,
            );
          },
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedGradientButton(
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width * 0.9,
              margin_left: 17,
              margin_right: 17,
              child: const Text("Go to home",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 1)),
              gradient: const LinearGradient(
                colors: <Color>[Color(0xffAEDC81), Color(0xff6CC51D)],
              ),
              onPressed: () => onhome_press(context),
            )
          ],
        ),
      ]),
    );
  }

  onhome_press(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const Home_Screen()),
        (Route<dynamic> route) => false);
  }
}
