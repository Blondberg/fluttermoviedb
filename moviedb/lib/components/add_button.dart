import 'package:flutter/material.dart';
import 'package:moviedb/constants.dart';

class MyAddButton extends StatelessWidget {
  const MyAddButton({Key? key}) : super(key: key);
  final double height = 50;
  final double width = 50;

  final Color color = kPrimaryPink;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4),
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(
          color: color,
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            blurStyle: BlurStyle.outer,
            blurRadius: 4,
            spreadRadius: 0,
            color: kPrimaryPink.withAlpha(50),
          ),
          BoxShadow(
              blurStyle: BlurStyle.outer,
              blurRadius: 2,
              spreadRadius: -1,
              color: kPrimaryPink.withAlpha(100))
        ],
      ),
      child: Center(
        child: Icon(
          Icons.add_rounded,
          color: Colors.white.withOpacity(.9),
          size: 30,
        ),
      ),
    );
  }
}
