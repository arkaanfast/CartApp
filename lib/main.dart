import 'package:cart_app/screens/authentication_screens/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/cart_list_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => CartListProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}
