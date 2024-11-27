import 'package:flutter/material.dart';
import 'package:manpro/utils/constants/image_string.dart';

class BackgroundAPP extends StatelessWidget {
  const BackgroundAPP({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFEFCFF5), // Light pink
            Color(0xFFFCFCFC), // White
          ],
        ),
      ),
    );
  }
}
