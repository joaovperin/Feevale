import 'package:client_app/pages/home.page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MfChat - Client',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const ChatRoomPage(),
      home: const HomePage(),
    );
  }
}
