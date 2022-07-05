import 'package:flutter/material.dart';

class ButtonWPopup extends StatefulWidget {
  const ButtonWPopup({Key? key}) : super(key: key);

  @override
  State<ButtonWPopup> createState() => _ButtonWPopupState();
}

class _ButtonWPopupState extends State<ButtonWPopup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      body: Column(
        children: [
          Expanded(
            child: SizedBox(),
          ),
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(border: Border.all()),
            height: 57,
            width: double.infinity,
            child: FloatingActionButton(
              onPressed: () => {},
              child: Icon(Icons.add_rounded),
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }
}
