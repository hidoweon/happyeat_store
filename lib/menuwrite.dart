import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:happyeat_store/controller/restaurant_controller.dart';
import 'package:happyeat_store/widget/edit.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class MenuCRUD extends StatefulWidget {
  MenuCRUD({Key? key}) : super(key: key);

  @override
  State<MenuCRUD> createState() => _MenuCRUDState();
}

class _MenuCRUDState extends State<MenuCRUD> {
  final documentId = Get.arguments as String;
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _menuController = TextEditingController();
  final TextEditingController _desController = TextEditingController();
  late File _image;
  final picker = ImagePicker();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('seoul');
  final restaurantsRef = FirebaseFirestore.instance.collection('seoul');
  int numItems = 0;
  bool noImage = true;
  bool _isMain = false;
  var restaurantController;

  @override

  Widget build(BuildContext context) {
      final restaurants = Get.find<RestaurantController>().restaurants;
      if (restaurants.isEmpty) {
        // handle the case where the list is empty
        return Container();
      }
      final restaurant = restaurants.firstWhere((r) => r.name == documentId);


    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("Clear"),
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                _clear();
                numItems = 0;
              },
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              child: Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: _menuController,
                      decoration: InputDecoration(hintText: 'Menu'),
                    ),
                  ),
                  Flexible(
                    child: TextField(
                      controller: _priceController,
                      decoration: InputDecoration(hintText: 'Price'),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _getImage();
                    },
                    icon: Icon(Icons.photo_camera),
                    tooltip: "사진 추가",
                  ),
                ],
              ),
            ),
            Row(children: <Widget>[
              Flexible(
                child: TextField(
                  controller: _desController,
                  decoration: InputDecoration(hintText: 'Description'),
                ),
              ),
              Flexible(
                flex: 1,
                child: SwitchListTile(
                  title: Text('isMain?'),
                  value: _isMain,
                  onChanged: (value) {
                    setState(() {
                      _isMain = value;
                    });
                  },
                ),
              ),
            ],),
            ElevatedButton(
              child: Text('Add'),
              onPressed: () async{
                if (noImage == false) {
                  await _add();
                } else {
                  await _noimageadd();
                }
                _urlController.clear();
                _menuController.clear();
                _priceController.clear();
                _desController.clear();
                setState(() {
                });
              },

            ),
            Container(
              height: 900,
              child: ListView.builder(
                itemCount: restaurant.menu.length,
                itemBuilder: (context, index) {
                  final item = restaurant.menu[index];
                  return ListTile(
                    leading: Image.network(item.imageUrl??''),
                    title: Text('메뉴이름 : ${item.name} 메인? ${item.isMain}'),
                    subtitle: Text('${item.price} won''${item.menudes}'),
                    trailing: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            iconSize: 15,
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Get.to(() => EditMenuDialog(menuItem: item, restaurantName: documentId)
                                  )?.then((value) => setState(() {}));
                            },
                          ),
                          IconButton(
                            iconSize: 15,
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              Get.defaultDialog(
                                title: "삭제",
                                middleText: "정말 삭제하시겠습니까?",
                                textConfirm: "삭제",
                                textCancel: "취소",
                                confirmTextColor: Colors.white,
                                cancelTextColor: Colors.white,
                                buttonColor: Colors.red,
                                onConfirm: () async {
                                  await Get.find<RestaurantController>().deleteMenu(
                                     documentId, item
                                  );
                                  Get.back();
                                  setState(() {});
                                },
                              )?.then((value) => setState(() {}));
                            },
                          ),
                        ],
                      ),
                    ),
                    // titleTextStyle: TextStyle(
                    //   color: Colors.black,
                    //   fontSize: 15,
                    //   fontWeight: FontWeight.bold,
                    // ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _clear() {
    setState(() {
      _urlController.clear();
      _menuController.clear();
      _priceController.clear();
      _desController.clear();
    });
  }

  Future<void> _add() async {
    final String restaurantName = documentId;
    final String menuName = _menuController.text;
    final String description = _desController.text;
    final int price = int.parse(_priceController.text);
    final String imageUrl = _urlController.text;

    final restaurantRef =
    FirebaseFirestore.instance.collection('seoul').where('name', isEqualTo: restaurantName);
    final snapshot = await restaurantRef.get();
    final String restaurantId = snapshot.docs.first.id;

    final firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('메뉴사진')
        .child(restaurantName)
        .child(menuName);
    final uploadTask = firebaseStorageRef.putFile(
      _image,
      SettableMetadata(
        contentType: 'image/jpeg',
      ),
    );
    await uploadTask.whenComplete(() => null);
    final downloadUrl = await firebaseStorageRef.getDownloadURL();

    final Map<String, dynamic> data = <String, dynamic>{
      'name': menuName,
      'price': price,
      'menudes': description,
      'imageUrl': downloadUrl ?? '',
      'isMain': _isMain,
    };

    _db
        .collection('seoul')
        .doc(restaurantId)
        .update({'menu.$menuName': data})
        .then((value) => print("Menu added successfully"))
        .catchError((error) => print("Failed to add menu: $error"));
  }


  Future _getImage() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery, maxWidth: 650, maxHeight: 100);
    // 사진의 크기를 지정 650*100 이유: firebase는 유료이다.
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        noImage = false;
      } else {
        print('No image selected.');
        noImage == true;
      }
    });
  }

  void _menuread() async {
    final name = documentId;
    final restaurantsRef = FirebaseFirestore.instance.collection('seoul');
    final snapshot = await restaurantsRef.where('name', isEqualTo: name).get();
    final snapshot2 =
        await snapshot.docs.first.reference.collection('menu').get();
    final String id = snapshot.docs.first.id;
    final QuerySnapshot result =
        await _db.collection('seoul').doc(id).collection('menu').get();
    final List<DocumentSnapshot> documents = result.docs;
    documents.forEach((data) {
      print(data['name']);
      print(data['price']);
      print(data['menudes']);
      print(data['ImageUrl']);
    });
  }

  Future<void> _noimageadd() async {
    final String name = documentId;
    final String menu = _menuController.text;
    final String des = _desController.text;
    final String price = _priceController.text;
    final restaurantsRef = FirebaseFirestore.instance.collection('restaurant');
    final snapshot = await restaurantsRef.where('name', isEqualTo: name).get();
    final String id = snapshot.docs.first.id;
    final Map<String, dynamic> data = <String, dynamic>{
      'name': menu,
      'price': price,
      'menudes': des,
      'imageUrl': '',
      'isMain': _isMain,
    };

    _db
        .collection('seoul')
        .doc(id)
        .update({'menu': FieldValue.arrayUnion([data])})
        .then((value) => print("Menu added without photo successfully"))
        .catchError((error) => print("Failed to add menu: $error"));
  }
}

