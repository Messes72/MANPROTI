import 'package:flutter/material.dart';
import 'package:manpro/common/widgets/background_app.dart';
import 'package:manpro/features/bagian_utama/Tampilan/contact/contact_yayasan_content.dart';
import 'package:manpro/features/bagian_utama/Tampilan/contact/tulisan_contact.dart';
import 'package:manpro/features/bagian_utama/Tampilan/profile_yayasan/widgets/tombol_back.dart';
import 'package:get/get.dart';
import 'package:manpro/navbar.dart';
import 'package:manpro/utils/constants/image_string.dart';

class KontakYayasan extends StatelessWidget {
  const KontakYayasan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundAPP(),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tombol back
                    IconButton(
                      onPressed: () {
                        final controller = Get.put(NavigationController());
                        controller.selectedIndex.value = 0; // Switch to Home tab
                        Get.to(() => const Navbar());
                      },
                      icon: const ImageIcon(
                        AssetImage(YPKImages.icon_back_button),
                        size: 32.0,
                      ),
                    ),

                    // Tulisan Kontak Yayasan
                    const TulisanKontak(),
                    const SizedBox(
                      height: 35.0,
                    ),

                    // Kontak Yayasan
                    const Padding(
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
