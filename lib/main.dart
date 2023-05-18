import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:happyeat_store/menuwrite.dart';
import 'package:happyeat_store/pages/login/login.dart';
import 'controller/restaurant_controller.dart';
import 'firebase_options.dart';
import 'firebaseCRUD.dart';
import 'navigationbar.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.lazyPut(()=>RestaurantController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int selectedIndex = 0;
  final ScrollController _homeController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MyLoginPage(title: "Login Page",),
    );
  }
}