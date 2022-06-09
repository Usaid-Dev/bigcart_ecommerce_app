import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Screens/ProductsByCategory_Screen.dart';
class categories_items extends StatelessWidget {
  final String image,title;
  final Color color;
  final int catID;

  const categories_items({Key? key, required this.image, required this.title, required this.color, required this.catID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap:()=>onCategoryPress(context,catID,title),
      child: Container(
        height: 78,
        margin: EdgeInsets.only(top:10 ,left: 15,right: 15),
        child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 52,
                    width: 52,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color,
                    ),
                    child: Center(child: Image.network(image,width: 26,height: 26,errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                      return const Text('no image');
                    })),
                  )
                ],
              ),
              SizedBox(height: 11),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 10,color: Color(0xff868889)))
                ],
              )
            ]),
      ),
    );
  }

  onCategoryPress(BuildContext context, int catID,String catName) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => Filtered_Products_Screen(catId: catID,catName: catName,)));
  }
}