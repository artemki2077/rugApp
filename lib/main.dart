import 'package:flutter/material.dart';
import 'package:rug/views/password.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'main',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: Passworrd(),
    );
  }
}
