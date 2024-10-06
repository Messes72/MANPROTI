import 'package:flutter/material.dart';
import 'package:manpro/features/Login/Tampilan/widgets/background_app.dart';
import 'package:manpro/features/Login/Tampilan/widgets/isi_login.dart';
import 'package:manpro/features/Login/Tampilan/widgets/logo_app.dart';
import 'package:manpro/features/Login/Tampilan/widgets/tulisan_bawah.dart';

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
