import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moviedb/components/add_button.dart';
import 'package:moviedb/constants.dart';
import 'package:simple_shadow/simple_shadow.dart';

class MyNavigationBar extends StatelessWidget {
  const MyNavigationBar(
      {Key? key,
      required this.onItemSelected,
      this.height = 90,
      required this.iconHeight,
      this.selectedIndex = 0,
      required this.size})
      : super(key: key);

  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final double height;
  final double iconHeight;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color(0xFF8C8BC5).withAlpha(100),
            ),
          ),
        ),
        height: height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: InkWell(
                splashFactory: NoSplash.splashFactory,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () => onItemSelected(0),
                child: MyNavbarItemWidget(
                    isSelected: 0 == selectedIndex,
                    item: NavBarItem(
                      onPress: () => {},
                      icon: "assets/icons/list.svg",
                    ),
                    height: height),
              ),
            ),
            const MyAddButton(),
            Expanded(
              child: InkWell(
                splashFactory: NoSplash.splashFactory,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () => onItemSelected(1),
                child: MyNavbarItemWidget(
                    isSelected: 1 == selectedIndex,
                    item: NavBarItem(
                      onPress: () => {},
                      icon: "assets/icons/person.svg",
                    ),
                    height: height),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyNavbarItemWidget extends StatelessWidget {
  MyNavbarItemWidget(
      {Key? key,
      required this.item,
      required this.isSelected,
      required this.height})
      : super(key: key);

  final NavBarItem item;
  final bool isSelected;
  final double height;

  final Color iconActive = kPrimaryBlue;
  final Color iconInactive = Color(0x80FFFFFF);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedPositioned(
            top: isSelected ? 60 : 40,
            duration: const Duration(milliseconds: 400),
            curve: Curves.elasticOut,
            child: SimpleShadow(
              color: isSelected ? iconActive : iconInactive,
              offset: const Offset(0, 0),
              child: Icon(
                color: isSelected ? iconActive : iconInactive,
                Icons.circle_outlined,
                size: 10,
              ),
            ),
          ),
          Container(
            color: kDefaultBackground,
            child: SimpleShadow(
              color: isSelected ? iconActive : iconActive.withAlpha(0),
              offset: const Offset(0, 0),
              child: SvgPicture.asset(
                item.icon,
                height: 20,
                color: isSelected ? iconActive : iconInactive,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NavBarItem {
  final String icon;
  final Function onPress;

  NavBarItem({required this.onPress, required this.icon});
}
