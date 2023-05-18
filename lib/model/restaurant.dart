import 'package:cloud_firestore/cloud_firestore.dart';

class Restaurant {
  final String name;
  final String kind;
  final String resdes;
  final String imageUrl1;
  final String address;
  final Map<String, String> hours;
  final List<MenuItem> menu;
  final bool isopen;
  final String? token;

  Restaurant({
    required this.name,
    required this.kind,
    required this.resdes,
    required this.imageUrl1,
    required this.address,
    required this.hours,
    required this.menu,
    required this.isopen,
    this.token,
  });


  factory Restaurant.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    final menuData = data['menu'];

    List<MenuItem> menu = [];

    if (menuData is List) {
      menu = menuData.map((item) => MenuItem.fromMap(item)).toList();
    } else if (menuData is Map) {
      // handle the case where menuData is a single object
      menu = [MenuItem.fromMap(
        Map<String, dynamic>.from(menuData),
      )];
    }

    return Restaurant(
      name: data['name'],
      kind: data['kind'],
      resdes: data['resdes'],
      imageUrl1: data['imageUrl1'],
      address: data['address'],
      hours: Map<String, String>.from(data['hours']),
      menu: menu,
      isopen: data['isopen'],
    );
  }


}

class MenuItem {
  final String name;
  final String menudes;
  final String imageUrl;
  final int price;
  final bool isMain;

  MenuItem({
    required this.name,
    required this.menudes,
    required this.imageUrl,
    required this.price,
    required this.isMain,
  });

  factory MenuItem.fromMap(Map<String, dynamic> map) {
    return MenuItem(
      name: map['name'] ?? '',
      menudes: map['menudes'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      price: map['price'] ?? '',
      isMain: map['ismain'] ?? false,
    );
  }
}
