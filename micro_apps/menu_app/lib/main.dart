import 'package:flutter/material.dart';

void main() => runApp(const MenuApp());

class MenuApp extends StatelessWidget {
  const MenuApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Center(
        child: Text("Menu App"),
      ),
    );
  }
}
