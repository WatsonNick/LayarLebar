import 'package:flutter/material.dart';
import 'package:layarlebar/screens/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Layar Lebar Movies',
      home: const HomePage(),
    );
  }
}
