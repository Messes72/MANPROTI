import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manpro/features/bagian_awal/controller/login_controller.dart';
import 'package:manpro/features/bagian_awal/tampilan/login/widgets/background_app.dart';
import 'package:manpro/features/bagian_awal/tampilan/login/widgets/isi_login.dart';
import 'package:manpro/features/bagian_awal/tampilan/login/widgets/logo_app.dart';
import 'package:manpro/features/bagian_awal/tampilan/login/widgets/tulisan_bawah.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

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
