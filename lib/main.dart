import 'package:flutter/material.dart';
import 'package:foodie_demo/Controller/auth.dart';
import 'package:foodie_demo/User_Screens/root_page.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Login',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RootPage(auth: new Auth()),
    );
  }
}