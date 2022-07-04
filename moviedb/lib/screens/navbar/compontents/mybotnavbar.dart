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
      height: 70,
      alignment: Alignment.center,
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
      child: const MyAddButton2(),
    );
  }
}


// Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           IconButton(
//             onPressed: () => onNavPress(0),
//             icon: const Icon(
//               Icons.list_rounded,
//               size: 29,
//             ),
//           ),
//           MyAddButton2(),
//           IconButton(
//             onPressed: () => onNavPress(1),
//             icon: const Icon(
//               Icons.person_rounded,
//               size: 29,
//             ),
//           ),
//         ],
//       ),