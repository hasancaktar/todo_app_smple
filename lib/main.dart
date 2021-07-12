import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_smple/screen/harita_screen.dart';
import 'package:todo_app_smple/screen/haritaview.dart';
import 'package:todo_app_smple/screen/todoscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: TodoScreen(),
    );
  }
}