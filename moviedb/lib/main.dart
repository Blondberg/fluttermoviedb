import 'package:flutter/material.dart';
import 'package:moviedb/screens/button_w_popup/buttonwpopup.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie database',
      home: const ButtonWPopup(),
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFAFAFA),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    ),
  );
}
