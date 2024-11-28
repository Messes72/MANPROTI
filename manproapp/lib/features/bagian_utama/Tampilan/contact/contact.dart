import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Importing Get package for navigation
import 'package:manpro/common/widgets/background_app.dart';
import 'package:manpro/features/bagian_utama/Tampilan/contact/contact_yayasan_content.dart';
import 'package:manpro/features/bagian_utama/Tampilan/contact/tulisan_contact.dart';
import 'package:manpro/features/bagian_utama/controllers/eventController.dart';
import 'package:manpro/navbar.dart';
import 'package:manpro/utils/constants/image_string.dart';

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
                    // Tombol back with navigation logic
                    _CustomBackButton(),

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

class _CustomBackButton extends StatelessWidget {
  const _CustomBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const ImageIcon(
        AssetImage(YPKImages.icon_back_button), // Use your asset image
        size: 32.0, // Icon size
      ),
      onPressed: () {
        final controller = Get.put(NavigationController());
        controller.selectedIndex.value = 0; // Switch to Home tab
        Get.to(() => const Navbar()); // Navigate to Navbar
      },
    );
  }
}