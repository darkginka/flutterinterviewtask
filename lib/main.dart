import 'package:flutterinterviewtask/screen/myLogin.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutterinterviewtask/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: Constants.APPNAME,
      theme: ThemeData(
        fontFamily: "Quicksand",
        colorScheme: ColorScheme.fromSeed(seedColor: Constants.primaryColor),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyLogin(),
    );
  }
}
