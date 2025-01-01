import 'package:flutter/material.dart';
import 'package:wordpairapp/homescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.purple[900]),
      debugShowCheckedModeBanner: false,
      title: 'PairWordFinder',
      home: Homescreen(),
    );
  }
}
