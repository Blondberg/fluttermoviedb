import 'package:flutter/material.dart';
import 'package:moviedb/screens/list/list_screen.dart';
import 'package:moviedb/screens/profile/profile_screen.dart';

import 'compontents/mybotnavbar.dart';

List<Widget> pages = [
  const ListScreen(),
  const ProfileScreen(),
];

class NavBarScreen extends StatefulWidget {
  NavBarScreen({Key? key}) : super(key: key);

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  final PageController _pageController = PageController();

  void _navPressed(int index) {
    setState(() {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: PageView(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        children: pages,
      ),
      bottomNavigationBar: MyBotNavBar(
        size: size,
        onNavPress: _navPressed,
      ),
    );
  }
}
