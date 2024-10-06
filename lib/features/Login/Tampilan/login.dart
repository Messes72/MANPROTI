import 'package:flutter/material.dart';
import 'package:manpro/common/widgets/login_form.dart';
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

          // Bagian isi tampilan
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Column(
                  children: [
                    // Gambar logo
                    LogoApp(),

                    // Bagian login
                    IsiLogin(),
                    SizedBox(height: 20.0),

                    // Bagian tulisan bawah
                    TulisanBawah()
                  ],
                ),
              ),
            ),
          ),
        ],
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

class IsiLogin extends StatelessWidget {
  const IsiLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
      height: 240.0,
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
      child: const Padding(
        padding: EdgeInsets.fromLTRB(15.0, 13.0, 13.0, 15.0),
        child: Column(
          children: [
            // Bagian tulisan login
            TulisanLogin(),
            SizedBox(height: 10.0),

            // Bagian text field
            Username(),
            Password(),
            SizedBox(height: 1.0),

            // Bagian tombol
            TombolLogin(),
          ],
        ),
      ),
    );
  }
}

class TulisanLogin extends StatelessWidget {
  const TulisanLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Login',
      style: TextStyle(
        fontFamily: 'NunitoSans',
        fontWeight: FontWeight.w800,
        fontSize: 20.0,
      ),
    );
  }
}

class Username extends StatelessWidget {
  const Username({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 60.0,
      child: CTextField(label: 'Username'),
    );
  }
}

class Password extends StatelessWidget {
  const Password({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 60.0,
      child: CTextField(label: 'Password', isPassword: true),
    );
  }
}

class TombolLogin extends StatelessWidget {
  const TombolLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170.0,
      child: ElevatedButton(
        onPressed: () {},
        child: const Text(
          'Login',
          style: TextStyle(
            fontFamily: 'NunitoSans',
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class TulisanBawah extends StatelessWidget {
  const TulisanBawah({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'Don’t Have an Account ? Sign Up Here',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'NunitoSans',
            fontWeight: FontWeight.w500,
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(height: 7.0),
        Text(
          'Forgot Password ?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'NunitoSans',
            fontWeight: FontWeight.w500,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }
}
