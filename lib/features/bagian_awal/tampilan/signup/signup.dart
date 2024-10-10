import 'package:flutter/material.dart';
import 'package:manpro/common/widgets/background_app.dart';
import 'package:manpro/features/bagian_awal/tampilan/signup/widgets/isi_signup.dart';
import 'package:manpro/features/bagian_awal/tampilan/signup/widgets/signup_logo_app.dart';
import 'package:manpro/features/bagian_awal/tampilan/signup/widgets/signup_tulisan_bawah.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          // Bagian bg app
          BackgroundAPP(),

          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Column(
                  children: [

                    // Bagian logo app
                    SignupLogoApp(),

                    // Bagian signup
                    IsiSignup(),
                    SizedBox(height: 20.0),

                    // Bagian tulisan bawah
                    SignupTulisanBawah(),
                    SizedBox(height: 100.0)
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
