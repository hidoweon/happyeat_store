import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happyeat_store/controller/restaurant_controller.dart';
import 'logout.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class MyLoginPage extends StatefulWidget {
  MyLoginPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyLoginPage createState() => _MyLoginPage();
}

class _MyLoginPage extends State<MyLoginPage> {
  late TextEditingController idController;
  late TextEditingController passController;
  String userInfo = ""; //user의 정보를 저장하기 위한 변수
  static final storage =
  new FlutterSecureStorage(); //flutter_secure_storage 사용을 위한 초기화 작업
  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    passController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }
  _asyncMethod() async {
    //read 함수를 통하여 key값에 맞는 정보를 불러오게 됩니다. 이때 불러오는 결과의 타입은 String 타입임을 기억해야 합니다.
    //(데이터가 없을때는 null을 반환을 합니다.)
    userInfo = (await storage!.read(key: "login"))!;
    print(userInfo);


    //user의 정보가 있다면 바로 로그아웃 페이지로 넝어가게 합니다.
    if (userInfo != null) {
      Get.find<RestaurantController>().goToRestaurantView(userInfo.split(" ")[1]);
      print("유저정보있음");
      print(userInfo.split(" ")[1].toString());
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: idController,
                decoration: InputDecoration(labelText: "id"),
              ),
              TextField(
                controller: passController,
                decoration: InputDecoration(labelText: "password"),
              ),
              ElevatedButton(child: Text("Login"),
                onPressed: () async {
                  // Firestore에서 사용자 인증 검증
                  final snapshot = await FirebaseFirestore.instance
                      .collection('seoul')
                      .where('name', isEqualTo: idController.text)
                      .where('token', isEqualTo: passController.text)
                      .get();

                  if (snapshot.docs.length == 1) { // 사용자 인증 성공
                    // write 함수를 통하여 key에 맞는 정보를 적게 됩니다.
                    //{"login" : "id id_value password password_value"}
                    //와 같은 형식으로 저장이 된다고 생각을 하면 됩니다.
                    await storage.write(
                        key: "login",
                        value: "id " +
                            idController.text.toString() +
                            " " +
                            "password " +
                            passController.text.toString());
                    Get.find<RestaurantController>().goToRestaurantView(idController.text.toString());
                  } else { // 사용자 인증 실패
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          AlertDialog(
                            title: const Text('로그인 실패'),
                            content: const Text(
                                'ID 또는 비밀번호가 올바르지 않습니다. 다시 시도해주세요.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _signIn(String id, String password) async {
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(
        id).get();
    if (userDoc.exists) { // 사용자 정보가 존재한다면
      final userData = userDoc.data() as Map<String, dynamic>;
      final savedPassword = userData['password'] as String;
      if (savedPassword == password) { // 비밀번호가 일치한다면
        // 로그인 성공 처리
        Get.find<RestaurantController>().goToRestaurantView(idController.text.toString());
      } else { // 비밀번호가 일치하지 않는다면
        showDialog(
          context: context,
          builder: (BuildContext context) =>
              AlertDialog(
                title: const Text('로그인 실패'),
                content: const Text('ID 또는 비밀번호가 올바르지 않습니다. 다시 시도해주세요.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              ),
        );
      }
    } else { // 사용자 정보가 존재하지 않는다면
      showDialog(
        context: context,
        builder: (BuildContext context) =>
            AlertDialog(
              title: const Text('로그인 실패'),
              content: const Text('ID 또는 비밀번호가 올바르지 않습니다. 다시 시도해주세요.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
      );
    }
  }
}
