import 'package:flutter/material.dart';
import 'package:manpro/common/widgets/background_app.dart';
import 'package:manpro/features/bagian_awal/tampilan/forget_password/widgets/fp_logo_app.dart';
import 'package:manpro/features/bagian_awal/tampilan/forget_password/widgets/fp_tulisan_bawah.dart';
import 'package:manpro/features/bagian_awal/tampilan/forget_password/widgets/isi_fp.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    FpLogoApp(),

                    // Bagian login
                    IsiFp(),
                    SizedBox(height: 20.0),

                    // Bagian tulisan bawah
                    FpTulisanBawah(),
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
