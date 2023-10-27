import 'package:assesment_task/view/list.dart';
import 'package:assesment_task/view/to_do_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: List_Screen(),
    );
  }
}
