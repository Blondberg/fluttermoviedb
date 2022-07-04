import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:moviedb/screens/navbar/compontents/add_button2.dart';

class MyBotBar extends StatefulWidget {
  const MyBotBar({Key? key}) : super(key: key);

  @override
  State<MyBotBar> createState() => _MyBotBarState();
}

class _MyBotBarState extends State<MyBotBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: MyAddButton2(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _currentIndex,
        elevation: 0,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "list",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "person",
          ),
        ],
      ),
    );
  }
}
