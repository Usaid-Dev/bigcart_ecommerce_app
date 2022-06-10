import 'package:flutter/material.dart';

class RaisedGradientButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final double width;
  final double height;
  final GestureTapCallback onPressed;
  final double margin_left,margin_right;
  final bool isdisabled;

  const RaisedGradientButton({Key? key,
    required this.gradient, required this.width, required this.height,
    required this.onPressed, required this.child, this.margin_left = 0.0,
    this.margin_right = 0.0, this.isdisabled = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.only(left: 17,right: 17),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(9)),
          gradient:isdisabled?const LinearGradient(
            colors:  <Color>[Color(0xffc7faa7), Color(0xffAEDC81)],
          ):gradient,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.5),
              blurRadius: 1.5,
            ),
      ]
      ),
      child: isdisabled?
          Center(child: child)
          :Material(color: Colors.transparent,
        child: InkWell(splashColor: Theme.of(context).primaryColorDark,
            borderRadius: const BorderRadius.all(Radius.circular(9)),
            onTap:()=>onPressed(),
            child: Center(child: child)
        ),
      ),
    );
  }
}