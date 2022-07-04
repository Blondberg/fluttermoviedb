import 'package:flutter/material.dart';
import 'package:moviedb/screens/navbar/navbar_screen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie database',
      home: NavBarScreen(),
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFAFAFA),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    ),
  );
}
