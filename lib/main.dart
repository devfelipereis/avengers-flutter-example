import 'package:flutter/material.dart';
import 'package:avengers/ui/views/home/home_page.dart';
import 'package:avengers/locator.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Avengers',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.black
      ),
      home: HomePage(),
    );
  }
}