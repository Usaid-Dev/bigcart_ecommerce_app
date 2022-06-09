import 'package:bigcart_ecommerce_app/Providers/cart_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class cart_item extends StatelessWidget {
  final String imgPath;
  final Color p_Color;
  final String p_Price, p_Title, p_Qty;
  final int p_Id;

  const cart_item(
      {required this.imgPath,
      required this.p_Color,
      required this.p_Price,
      required this.p_Title,
      required this.p_Qty,
        required this.p_Id
      });

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        margin: EdgeInsets.all(6),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 64,
                      width: 64,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: p_Color,
                      ),
                      child: Image.network(imgPath, width: 26, height: 26,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                        return Center(child: const Text('no image'));
                      }, alignment: Alignment.bottomCenter),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(p_Price,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).primaryColorDark)),
                          Text(p_Title,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black)),
                          Text(p_Qty,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff868889))),
                        ]),
                    Spacer(),
                    Consumer<Cart_Provider>(
                      builder: (context, provider, child) {
                        return Column(
                          children: [
                            Material(
                                color: Colors.transparent,
                                child: InkWell(
                                    borderRadius: BorderRadius.circular(20),
                                    onTap: () {provider.incrementProductQyt(p_Id);},
                                    child: Icon(Icons.add_outlined,
                                        color: Theme.of(context)
                                            .primaryColorDark))),
                            SizedBox(height: 10),
                            Text('${provider.getProductQyt(p_Id)}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff868889),
                                    fontSize: 15)),
                            SizedBox(height: 10),
                            Material(
                                color: Colors.transparent,
                                child: InkWell(
                                    borderRadius: BorderRadius.circular(20),
                                    onTap: () {provider.decrementProductQyt(p_Id);},
                                    child: Icon(Icons.remove_outlined,
                                        color: Theme.of(context)
                                            .primaryColorDark))),
                          ],
                        );
                      },
                    )
                  ],
                ),
              ],
            )));
  }
}
