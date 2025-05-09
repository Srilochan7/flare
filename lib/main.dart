import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'home.dart';  // Use the correct import path

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
          title: 'LED Scroller App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            brightness: Brightness.dark,
          ),
          home: const Home(),
          debugShowCheckedModeBanner: false,
        );

  }
}