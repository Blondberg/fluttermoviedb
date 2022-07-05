import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ListViewScreen extends StatefulWidget {
  const ListViewScreen({Key? key, required this.db, this.currentUser})
      : super(key: key);
  final FirebaseFirestore db;
  final GoogleSignInAccount? currentUser;

  @override
  State<ListViewScreen> createState() => _ListViewScreenState();
}

class _ListViewScreenState extends State<ListViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("list view"),
      ),
      body: Center(
        child: Text(widget.currentUser!.email),
      ),
    );
  }
}
