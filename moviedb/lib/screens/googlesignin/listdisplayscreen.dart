import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:http/http.dart' as http;

class ListViewScreen extends StatefulWidget {
  const ListViewScreen({Key? key, required this.db, this.currentUser})
      : super(key: key);
  final FirebaseFirestore db;
  final GoogleSignInAccount? currentUser;

  @override
  State<ListViewScreen> createState() => _ListViewScreenState();
}

class _ListViewScreenState extends State<ListViewScreen> {
  String output = "sdf";

  List<List<dynamic>> _data = [];
  List<List<dynamic>> items = [];

  void getLists() async {
    // get all the lists for the user
    final docRef =
        widget.db.collection("spreadsheetids").doc(widget.currentUser!.email);
    docRef.get().then((DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      setState(() {
        data.forEach((key, value) async {
          http.Response response = await http.get(
            Uri.parse("https://sheets.googleapis.com/v4/spreadsheets/$key"),
            headers: await widget.currentUser!.authHeaders,
          );
          if (response.statusCode == 200) {
            String sheetTitle =
                jsonDecode(response.body)["sheets"][0]["properties"]["title"];
            http.Response resp = await http.get(
              Uri.parse(
                  "https://sheets.googleapis.com/v4/spreadsheets/$key/values/$sheetTitle"),
              headers: await widget.currentUser!.authHeaders,
            );
            var valuesJson = jsonDecode(resp.body)["values"];
            List<List<dynamic>> valuesList = List.from(valuesJson);
            _data = valuesList;
            items.clear();
            items.addAll(_data);
          } else {
            output = "error";
          }
        });
      });
    });
  }

  void extractListData(String listId) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("list view"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: getLists, child: Text("Get lists")),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: ((context, index) {
                  return Card(
                    child: ListTile(
                      leading: Text(items[index][0].toString()),
                      title: Text(items[index][1].toString()),
                      trailing: Text(items[index][2].toString()),
                    ),
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
