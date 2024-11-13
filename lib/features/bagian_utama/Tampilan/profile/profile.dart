import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manpro/common/widgets/background_app.dart';
import 'package:manpro/navbar.dart';
import 'package:manpro/utils/constants/image_string.dart';
import 'package:manpro/features/bagian_utama/Tampilan/profile/edit_profile.dart'; // Import the edit profile page

class Profile extends StatelessWidget {
  const Profile({super.key});

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
                    IconButton(
                      onPressed: () => Get.to(() => const Navbar()),
                      icon: const ImageIcon(
                        AssetImage(YPKImages.icon_back_button),
                        size: 32.0,
                      ),
                    ),
                    const SizedBox(height: 25.0),
                    const Center(
                      child: Text(
                        'My Profile',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                          fontSize: 24.0,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              const CircleAvatar(
                                radius: 100,
                                backgroundImage:
                                    AssetImage(YPKImages.gbr_event1),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: IconButton(
                                  icon: const ImageIcon(
                                    AssetImage(YPKImages.icon_edit_gbr),
                                    size:
                                        32.0, // You can change this size to edit the icon size
                                  ),
                                  onPressed: () {
                                    // Add edit profile picture functionality
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          buildProfileField(
                              "Jehezkiel",
                              const TextStyle(
                                  fontFamily: "NunitoSans",
                                  fontWeight: FontWeight.w700)),
                          buildProfileField(
                              "Louis",
                              const TextStyle(
                                  fontFamily: "NunitoSans",
                                  fontWeight: FontWeight.w700)),
                          buildProfileField(
                              "jehezkiel@gmail.com",
                              const TextStyle(
                                  fontFamily: "NunitoSans",
                                  fontWeight: FontWeight.w700)),
                          buildProfileField(
                              "08178787878",
                              const TextStyle(
                                  fontFamily: "NunitoSans",
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Get.to(() =>
                                      const EditProfile()); // Navigate to the edit profile page
                                },
                                child: const Text(
                                  'Edit profile detail',
                                  style: TextStyle(
                                    fontFamily: 'NunitoSans',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                            ],
                          ),
                        ],
                      ),
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

  Widget buildProfileField(String value, TextStyle style) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        readOnly: true,
        decoration: InputDecoration(
          hintText: value,
          hintStyle: style,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
