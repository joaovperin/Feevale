import 'package:client_app/app_pages.dart';
import 'package:client_app/domain/auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppAuthProvider.listen(),
      child: const MyApp(),
    ),
  );
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
      initialRoute: AppPages.initialRoute,
      routes: AppPages.routes,
      debugShowCheckedModeBanner: true,
    );
  }
}
