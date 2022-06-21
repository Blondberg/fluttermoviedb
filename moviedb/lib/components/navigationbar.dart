import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  void _onItemTapped(int index) {}

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.call),
          label: "Calls",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.call),
          label: "Second call",
        )
      ],
      onTap: _onItemTapped,
    );
  }
}
