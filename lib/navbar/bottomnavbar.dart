import 'package:flutter/material.dart';
import 'package:dole/model/screenModel.dart';

class BottomNavBar extends StatefulWidget {
  final Function(int) onTap;
  final List<ScreenModel> screens;
  final int currentIndex;

  const BottomNavBar({
    Key? key,
    required this.onTap,
    required this.screens,
    required this.currentIndex,
  }) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black,
      onTap: (index) {
        widget.onTap(index);
      },
      items: List.generate(
        widget.screens.length,
        (index) => BottomNavigationBarItem(
          icon: widget.screens[index].icon,
          label: widget.screens[index].label,
        ),
      ),
    );
  }
}

class ScreenModel {
  final Icon icon;
  final String label;

  ScreenModel({required this.icon, required this.label});
}
