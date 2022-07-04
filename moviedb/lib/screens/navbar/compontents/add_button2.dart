import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moviedb/constants.dart';
import 'package:simple_shadow/simple_shadow.dart';

import 'package:google_sign_in/google_sign_in.dart';

class MyAddButton2 extends StatefulWidget {
  const MyAddButton2({Key? key}) : super(key: key);

  @override
  State<MyAddButton2> createState() => _MyAddButton2State();
}

class _MyAddButton2State extends State<MyAddButton2> {
  double height = 60;
  double width = 60;

  final Color blue = const Color(0xFF63B4FF);

  final Color green = const Color(0xFF8FFF9B);

  late LinearGradient gradient;

  late GoogleSignIn _googleSignIn;

  @override
  void initState() {
    super.initState();
    gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        blue,
        green,
      ],
    );

    _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
  }

  double searchLeft = 40;
  double searchTop = 40;
  double addRight = 0;
  double addTop = 0;

  bool isOpened = false;

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  void _toggleOptions() {
    setState(() {
      isOpened = !isOpened;
      if (!isOpened) {
        print("Options close");
        searchLeft = 40;
        searchTop = 40;
      } else {
        print("Options open");

        searchLeft = 0;
        searchTop = 0;
      }
    });
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        if (!isOpened) {
          addRight = 0;
          addTop = 0;
        } else {
          addRight = -40;
          addTop = -40;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: _handleSignIn,
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  spreadRadius: 1,
                  color: Colors.black.withAlpha(25),
                ),
              ],
            ),
            child: Center(
              child: SimpleShadow(
                color: Colors.black,
                opacity: 0.60,
                sigma: 1,
                offset: const Offset(0, 0),
                child: SvgPicture.asset(
                  "assets/icons/barcode.svg",
                  height: 24,
                  width: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        // PopupChoiceButton(
        //   top: searchTop,
        //   left: searchLeft,
        //   height: 40,
        //   width: 40,
        //   gradient: gradient,
        //   icon: "assets/icons/search.svg",
        //   onTap: () => {print("Search")},
        // ),
        // PopupChoiceButton(
        //   top: addTop,
        //   right: addRight,
        //   height: 40,
        //   width: 40,
        //   gradient: gradient,
        //   icon: "assets/icons/add.svg",
        //   onTap: () => {print("add")},
        // ),
      ],
    );
  }
}

class PopupChoiceButton extends StatelessWidget {
  const PopupChoiceButton({
    Key? key,
    this.top,
    this.left,
    required this.height,
    required this.width,
    required this.gradient,
    required this.icon,
    this.bottom,
    this.right,
    required this.onTap,
  }) : super(key: key);

  final double? top;
  final double? left;
  final double? bottom;
  final double? right;
  final double height;
  final double width;
  final String icon;
  final LinearGradient gradient;

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      curve: Curves.elasticInOut,
      top: top,
      left: left,
      bottom: bottom,
      right: right,
      duration: const Duration(
        milliseconds: 800,
      ),
      child: InkWell(
        onTap: () => {print("TAPPING")},
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: gradient,
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                spreadRadius: 0,
                color: Colors.black.withAlpha(25),
              )
            ],
          ),
          child: Center(
            child: SimpleShadow(
              color: Colors.black,
              opacity: 0.60,
              sigma: 1,
              offset: const Offset(0, 0),
              child: SvgPicture.asset(
                icon,
                height: 20,
                width: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
