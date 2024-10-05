import 'package:flutter/material.dart';
import 'package:manpro/utils/constants/image_string.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          // Bagian bg app
          BackgroundAPP(),

          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: Column(
              children: [
                // Gambar logo
                LogoApp(),
                SizedBox(height: 0.0),

                // Bagian login
                IsiLogin(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class IsiLogin extends StatelessWidget {
  const IsiLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
      height: 210.0,
      decoration: BoxDecoration(
        color: Colors.indigo[100],
        borderRadius: BorderRadius.circular(40.0),
        border: Border.all(
          color: Colors.black.withOpacity(0.4),
          width: 1.8,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3.0,
            blurRadius: 3.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 13.0, 13.0, 15.0),
        child: Column(
          children: [
            Container(
              child: const Center(
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontFamily: 'NunitoSans',
                    fontWeight: FontWeight.w800,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}

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

class BackgroundAPP extends StatelessWidget {
  const BackgroundAPP({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(YPKImages.background),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
