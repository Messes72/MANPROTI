import 'package:flutter/material.dart';
import 'package:manpro/common/widgets/background_app.dart';
import 'package:manpro/features/bagian_awal/tampilan/resubmission_password/widgets/isi_rsp.dart';
import 'package:manpro/features/bagian_awal/tampilan/resubmission_password/widgets/rsp_logo_app.dart';
import 'package:manpro/features/bagian_awal/tampilan/resubmission_password/widgets/rsp_tulisan_bawah.dart';

class ResubmissionPassword extends StatelessWidget {
  const ResubmissionPassword({super.key});

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
                    RspLogoApp(),

                    // Bagian login
                    IsiRsp(),
                    SizedBox(height: 20.0),

                    // Bagian tulisan bawah
                    RspTulisanBawah(),
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
