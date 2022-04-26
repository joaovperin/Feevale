import 'package:client_app/app_pages.dart';
import 'package:client_app/domain/auth/app_auth_provider.dart';
import 'package:client_app/domain/settings/app_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppSettingsProvider.listen()),
        ChangeNotifierProvider(create: (_) => AppAuthProvider.listen()),
      ],
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
