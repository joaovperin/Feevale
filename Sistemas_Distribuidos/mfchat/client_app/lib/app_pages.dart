import 'package:client_app/pages/chatroom/chatroom.page.dart';
import 'package:client_app/pages/home.page.dart';
import 'package:flutter/material.dart';

class AppPages {
  const AppPages._();

  static const String initialRoute = HomePage.routeName;

  static final routes = {
    HomePage.routeName: (BuildContext context) => const HomePage(),
    ChatroomPage.routeName: (BuildContext context) => const ChatroomPage(),
  };
}
