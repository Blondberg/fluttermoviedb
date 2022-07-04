import 'package:flutter/material.dart';

import 'add_button2.dart';

class MyBotNavBar extends StatelessWidget {
  const MyBotNavBar({
    Key? key,
    required this.size,
    required this.onNavPress,
  }) : super(key: key);

  final Size size;
  final Function onNavPress;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: 57,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -3),
            blurRadius: 4,
            spreadRadius: 0,
            color: Colors.black.withAlpha(9),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () => onNavPress(0),
            icon: const Icon(
              Icons.list_rounded,
              size: 29,
            ),
          ),
          SizedBox(
            width: 60,
            child: Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: const [
                  Positioned(
                    top: -25,
                    child: MyAddButton2(),
                  )
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () => onNavPress(1),
            icon: const Icon(
              Icons.person_rounded,
              size: 29,
            ),
          ),
        ],
      ),
    );
  }
}
