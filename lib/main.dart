import 'package:flutter/material.dart';
import 'package:songsapp/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Songs App',
      theme: ThemeData(
        useMaterial3: true,
      ),
      //call splast instad home
      home: const Home(),
    );
  }
}
