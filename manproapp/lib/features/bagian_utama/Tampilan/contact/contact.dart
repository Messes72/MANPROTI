import 'package:flutter/material.dart';
import 'package:manpro/common/widgets/background_app.dart';
import 'package:manpro/features/bagian_utama/Tampilan/contact/contact_yayasan_content.dart';
import 'package:manpro/features/bagian_utama/Tampilan/contact/tulisan_contact.dart';
import 'package:manpro/features/bagian_utama/Tampilan/profile_yayasan/widgets/tombol_back.dart';

class KontakYayasan extends StatelessWidget {
  const KontakYayasan({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          BackgroundAPP(),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tombol back
                    TombolBack(),

                    // Tulisan Kontak Yayasan
                    TulisanKontak(),
                    SizedBox(
                      height: 35.0,
                    ),

                    // Kontak Yayasan
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: KontakYayasanContent(),
                    ),
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
