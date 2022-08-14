import 'package:flutter/material.dart';
import 'constants.dart';
import 'views/character_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  final title = Constants.title;
  final color = Constants.primColor;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeData td = ThemeData(primarySwatch: color);
    return MaterialApp(
      title: title,
      theme: td,
      home: const HomePage(),
    );
  }
}
