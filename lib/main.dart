// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:search_bar/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Flutter Demo',
      theme: ThemeData(
          //primarySwatch: Colors.purple,
          ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
