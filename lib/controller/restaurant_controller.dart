import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:happyeat_store/main.dart';
import 'package:happyeat_store/pages/home/homepage.dart';
import '../menuwrite.dart';
import '../model/restaurant.dart';

class RestaurantController extends GetxController {
  final CollectionReference _restaurantsRef =
  FirebaseFirestore.instance.collection('seoul');
  final RxList<Restaurant> _restaurants = RxList<Restaurant>();

  List<Restaurant> get restaurants => _restaurants;

  @override
  void onInit() {
    super.onInit();
    // Remove the hardcoded document ID and subscribe to changes in the collection instead
    _restaurantsRef.snapshots().listen((snapshot) {
      final restaurants = snapshot.docs.map((doc) => Restaurant.fromSnapshot(doc)).toList();
      _restaurants.value = restaurants;
    });
  }

  void goToRestaurantView(String documentId) {
    // Navigate to the RestaurantView with the given document ID as an argument
    //final documentId = Get.arguments as String;
    Get.to(() => MenuCRUD(), arguments: documentId);
    }


  Future<void> updateRestaurant(Restaurant restaurant) async {
    try {
      final index = _restaurants.indexWhere((r) => r.name == restaurant.name);
      if (index >= 0) {
        _restaurants[index] = restaurant;
        await _restaurantsRef.doc(restaurant.name).update({
          'kind': restaurant.kind,
          'resdes': restaurant.resdes,
          'imageUrl1': restaurant.imageUrl1,
          'address': restaurant.address,
          'hours': restaurant.hours,
          'menu': restaurant.menu.map((item) => {
            'name': item.name,
            'menudes': item.menudes,
            'imageUrl': item.imageUrl,
            'price': item.price,
            'ismain': item.isMain,
          }).toList(),
          'isopen': restaurant.isopen,
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateMenu(String restaurantName, MenuItem item) async {
    try {
      final restaurant = _restaurants.firstWhere((r) => r.name == restaurantName,);
      if (restaurant == null) {
        // Restaurant not found
        return;
      }
      final menu = restaurant.menu;
      final index = menu.indexWhere((m) => m.name == item.name);
      if (index == -1) {
        print("menu item not found");
        // Menu item not found
        return;
      }
      menu[index] = item;
      menu.insert(index, item);
      await _restaurantsRef.doc(restaurant.name).update({
        'menu': menu.map((m) => {
          'name': m.name,
          'menudes': m.menudes,
          'imageUrl': m.imageUrl,
          'price': m.price,
          'ismain': m.isMain,
        }).toList(),
      });
    } catch (e) {
      print(e.toString());
    }
  }
  Future<void> deleteMenu(String restaurantName, MenuItem item,) async {
    try {
      final restaurant = _restaurants.firstWhere((r) => r.name == restaurantName);
      if (restaurant == null) {
        // Restaurant not found
        return;
      }
      final menu = restaurant.menu;
      final index = menu.indexWhere((m) => m.name == item.name);

      if (index == -1) {
        // Menu item not found
        return;
      }
      await _restaurantsRef.doc(restaurant.name).update({
        'menu.${item.name}': FieldValue.delete(),
      });
    } catch (e) {
      print(e.toString());
    }
  }


}

