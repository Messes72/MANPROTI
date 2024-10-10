import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manpro/features/bagian_awal/tampilan/forget_password/forget_password.dart';
import 'package:manpro/features/bagian_awal/tampilan/login/login.dart';
import 'package:manpro/features/bagian_awal/tampilan/resubmission_password/resubmission_password.dart';
import 'package:manpro/features/bagian_awal/tampilan/signup/signup.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: ResubmissionPassword(),
    );
  }
}
