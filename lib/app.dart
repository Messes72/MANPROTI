import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manpro/features/Login/Tampilan/login/login.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Login(),
    );
  }
}
