import 'package:flutter/material.dart';

class BottomMenu extends StatelessWidget {

  final selectedIndex;
  ValueChanged<int> onClicked;

  BottomMenu({this.selectedIndex, required this.onClicked});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: selectedIndex,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.amber[800],
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: onClicked,

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.man),
            label: 'people',
          ),

        ]);
  }
}