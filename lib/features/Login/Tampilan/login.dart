import 'package:flutter/material.dart';
import 'package:manpro/utils/constants/image_string.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(YPKImages.background),
          )
        ),
      ),
    );
  }
}
