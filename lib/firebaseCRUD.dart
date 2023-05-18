import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseCRUD extends StatefulWidget {
  @override
  _FirebaseCRUDState createState() => _FirebaseCRUDState();
}
/*Map<String, dynamic> user = <String, dynamic>{
      'name': name,
      'kind': kind,
      'address': address,
      '상권': area,
      'ImageUrl': url,
    };

    */
class _FirebaseCRUDState extends State<FirebaseCRUD> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _kindController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  CollectionReference users =
  FirebaseFirestore.instance.collection('restaurant');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase CRUD'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(hintText: 'Name'),
            ),
            TextField(
              controller: _kindController,
              decoration: InputDecoration(hintText: 'kind'),
            ),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(hintText: 'address'),
            ),
            TextField(
              controller: _areaController,
              decoration: InputDecoration(hintText: '상권'),
            ),
            TextField(
              controller: _urlController,
              decoration: InputDecoration(hintText: 'ImageUrl'),
            ),
            ElevatedButton(
              child: Text('Add'),
              onPressed: () {
                _add();
              },
            ),
            StreamBuilder<QuerySnapshot>(
              stream: _db.collection('restaurant').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return LinearProgressIndicator();
                return Column(
                  children: snapshot.data!.docs.map((document) {
                    return ListTile(
                      title: Text(document['name']),
                      subtitle: Text(document['kind'].toString()),
                    );
                  }).toList(),
                );
              },
            )
          ],
        ),
      ),


      );
  }

  void _add() {
    final String name = _nameController.text;
    final String kind = _kindController.text;
    final String address = _addressController.text;
    final String area = _areaController.text;
    final String url = _urlController.text;

    Map<String, dynamic> user = <String, dynamic>{
      'name': name,
      'kind': kind,
      'address': address,
      //주소는 나중에 시, 구, 동으로 나눠서 저장해야함
      '상권': area,
      'ImageUrl': url,
      //url은 firebase storage에 저장해야
    };

    _db.collection('restaurant').add(user).then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
