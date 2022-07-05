import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>["https://www.googleapis.com/auth/spreadsheets"],
);

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  GoogleSignInAccount? _currentUser;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {}
    });
    _googleSignIn.signInSilently();
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _initializeNewList(GoogleSignInAccount user, String title,
      List<String> columnHeaders) async {
    http.Response response = await http.post(
      Uri.parse(
        "https://sheets.googleapis.com/v4/spreadsheets/",
      ),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      print("Error response: ${response.statusCode}");
    } else {
      // Id of newly created spreadsheet
      String spreadsheetId = jsonDecode(response.body)["spreadsheetId"];

      // Rename spreadsheet
      response = await http.post(
        Uri.parse(
          "https://sheets.googleapis.com/v4/spreadsheets/$spreadsheetId:batchUpdate",
        ),
        body: jsonEncode({
          "requests": [
            {
              "updateSpreadsheetProperties": {
                "properties": {"title": title},
                "fields": "title"
              }
            }
          ]
        }),
        headers: await user.authHeaders,
      );
      final data = <String, dynamic>{
        spreadsheetId: title,
      };
      db
          .collection("spreadsheetids")
          .doc(user.email)
          .set(data, SetOptions(merge: true));
      response = await http.post(
        Uri.parse(
          "https://sheets.googleapis.com/v4/spreadsheets/$spreadsheetId/values:batchUpdate",
        ),
        body: jsonEncode({
          "valueInputOption": "RAW",
          "data": [
            {
              "values": [columnHeaders],
              "range": "1:1"
            }
          ]
        }),
        headers: await user.authHeaders,
      );
    }
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _columnController1 = TextEditingController();
  final TextEditingController _columnController2 = TextEditingController();
  final TextEditingController _columnController3 = TextEditingController();

  Widget _buildBody() {
    final GoogleSignInAccount? user = _currentUser;
    if (user != null) {
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ListTile(
              leading: GoogleUserCircleAvatar(
                identity: user,
              ),
              title: Text(user.displayName ?? ''),
              subtitle: Text(user.email),
            ),
            const Text('Signed in successfully.'),
            Text("SIGN IN"),
            ElevatedButton(
              onPressed: _handleSignOut,
              child: const Text('SIGN OUT'),
            ),
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                label: Text("List title"),
              ),
            ),
            TextFormField(
              controller: _columnController1,
              decoration: const InputDecoration(
                label: Text("Column 1"),
              ),
            ),
            TextFormField(
              controller: _columnController2,
              decoration: const InputDecoration(
                label: Text("Column 2"),
              ),
            ),
            TextFormField(
              controller: _columnController3,
              decoration: const InputDecoration(
                label: Text("Column 3"),
              ),
            ),
            ElevatedButton(
              child: const Text('Create new list'),
              onPressed: () => _initializeNewList(
                user,
                _titleController.text,
                [
                  _columnController1.text,
                  _columnController2.text,
                  _columnController3.text
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Text('You are not currently signed in.'),
          ElevatedButton(
            onPressed: _handleSignIn,
            child: const Text('SIGN IN'),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Google Sign In'),
        ),
        body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: _buildBody(),
        ));
  }
}
