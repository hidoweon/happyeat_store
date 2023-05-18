
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:happyeat_store/firebaseCRUD.dart';
import 'package:happyeat_store/menuwrite.dart';
import 'package:happyeat_store/navigationbar.dart';

class HomePage extends StatefulWidget {
  final String documentId;
  HomePage({required this.documentId});
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  static final storage = FlutterSecureStorage();
  int selectedIndex = 0;
  final ScrollController _homeController = ScrollController();
  late String documentId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomMenu(
        selectedIndex: selectedIndex,
        onClicked: (index) => setState(() => selectedIndex = index),
      ),

      body: Center(
        child: _widgetOptions.elementAt(selectedIndex),
      ),
    );
  }

  List _widgetOptions = [
    FirebaseCRUD(),
    MenuCRUD(),
    Text('구현중')
  ];
}

//firebaseCRUD.dart

