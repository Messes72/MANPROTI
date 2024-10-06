import 'package:flutter/material.dart';
import 'package:manpro/utils/constants/image_string.dart';

class LogoApp extends StatelessWidget {
  const LogoApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.2,
      child: const Image(
        height: 300.0,
        image: AssetImage(YPKImages.logo),
        fit: BoxFit.contain,
      ),
    );
  }
}