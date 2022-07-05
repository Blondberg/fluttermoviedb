import 'dart:async';
import 'package:flutter/material.dart';
import 'package:moviedb/screens/googlesignin/signin_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie database',
      home: const SignInScreen(),
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFAFAFA),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    ),
  );
}
