

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happyeat_store/routes/names.dart';

import 'observers.dart';

class AppPages {
  static const INITIAL = AppRoutes.INITIAL;
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];

  static final List<GetPage> routes = [
    // 免登陆
    /*GetPage(
      name: AppRoutes.INITIAL,
      page: () => const WelcomePage(),
      binding: WelcomeBinding(),
    ),
    GetPage(name: AppRoutes.Profile, page: () => ProfilePage(), binding: ProfileBinding()),
    GetPage(
      name: AppRoutes.SIGN_IN,
      page: () => const SignInPage(),
      binding: SignInBinding(),
    ),
    GetPage(name: AppRoutes.Contact, page: () => const ContactPage(), binding: ContactBinding()),
    GetPage(name: AppRoutes.Chat, page: () => const ChatPage(), binding: ChatBinding()),
  GetPage(name: AppRoutes.Message, page: () => const MessagePage(), binding: MessageBinding(),middlewares: [
  RouteAuthMiddleware(priority: 1),
*/
  /*],),
*/
    // 需要登录
    // GetPage(
    //   name: AppRoutes.Application,
    //   page: () => ApplicationPage(),
    //   binding: ApplicationBinding(),
    //   middlewares: [
    //     RouteAuthMiddleware(priority: 1),
    //   ],
    // ),

 /*   // 最新路由
    GetPage(name: AppRoutes.EmailLogin, page: () => EmailLoginPage(), binding: EmailLoginBinding()),
    GetPage(name: AppRoutes.Register, page: () => RegisterPage(), binding: RegisterBinding()),
    GetPage(name: AppRoutes.Forgot, page: () => ForgotPage(), binding: ForgotBinding()),
    GetPage(name: AppRoutes.Phone, page: () => PhonePage(), binding: PhoneBinding()),
    GetPage(name: AppRoutes.SendCode, page: () => SendCodePage(), binding: SendCodeBinding()),
    // 首页

    //消息

    //我的

    //聊天详情


    GetPage(name: AppRoutes.Photoimgview, page: () => PhotoImgViewPage(), binding: PhotoImgViewBinding()),
    GetPage(name: AppRoutes.VoiceCall, page: () => VoiceCallViewPage(), binding: VoiceCallViewBinding()),
    GetPage(name: AppRoutes.VideoCall, page: () => VideoCallPage(), binding: VideoCallBinding()),*/
  ];






}
