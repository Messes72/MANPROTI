import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manpro/common/widgets/background_app.dart';
import 'package:manpro/features/bagian_utama/Tampilan/profile/edit_profile/edit_profile.dart';
import 'package:manpro/navbar.dart';
import 'package:manpro/utils/constants/image_string.dart';
import 'package:manpro/features/bagian_utama/controllers/profileController.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundAPP(),
          SafeArea(
            child: Obx(() {
              if (profileController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              final user = profileController.userData;

              return SingleChildScrollView(
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
                      const SizedBox(height: 20.0),
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
                                      size: 32.0,
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
                              'Nama Lengkap',
                              user['nama_lengkap'] ?? '',
                              const TextStyle(
                                fontFamily: "NunitoSans",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            buildProfileField(
                              'Username',
                              user['username'] ?? '',
                              const TextStyle(
                                fontFamily: "NunitoSans",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            buildProfileField(
                              'Email',
                              user['email'] ?? '',
                              const TextStyle(
                                fontFamily: "NunitoSans",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            buildProfileField(
                              'Kota Asal',
                              user['kota_asal'] ?? '',
                              const TextStyle(
                                fontFamily: "NunitoSans",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            buildProfileField(
                              'No Telpon',
                              user['no_telpon'] ?? '',
                              const TextStyle(
                                fontFamily: "NunitoSans",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () => Get.to(() => EditProfile(
                                    userData: Map<String, dynamic>.from(
                                        profileController.userData),
                                  )),
                              child: const Text(
                                'Edit Profile',
                                style: TextStyle(
                                  fontFamily: 'NunitoSans',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget buildProfileField(String label, String value, TextStyle style) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextField(
        readOnly: true,
        controller: TextEditingController(text: value),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            fontFamily: 'NunitoSans',
            fontWeight: FontWeight.w700,
          ),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
