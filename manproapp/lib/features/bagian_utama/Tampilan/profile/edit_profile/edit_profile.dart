import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manpro/common/widgets/background_app.dart';
import 'package:manpro/features/bagian_utama/Tampilan/profile/profile.dart';
import 'package:manpro/utils/constants/image_string.dart';
import 'package:manpro/features/bagian_utama/controllers/profileController.dart';

class EditProfile extends StatelessWidget {
  final Map<String, dynamic> userData;
  final profileController = Get.find<ProfileController>();

  EditProfile({
    super.key,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
    final namaLengkapController =
        TextEditingController(text: userData['nama_lengkap']);
    final usernameController =
        TextEditingController(text: userData['username']);
    final emailController = TextEditingController(text: userData['email']);
    final kotaAsalController =
        TextEditingController(text: userData['kota_asal']);
    final noTelponController =
        TextEditingController(text: userData['no_telpon']);

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundAPP(),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () => Get.to(() => const Profile()),
                      icon: const ImageIcon(
                        AssetImage(YPKImages.icon_back_button),
                        size: 32.0,
                      ),
                    ),
                    const SizedBox(height: 25.0),
                    const Text(
                      'Edit Profile',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        fontSize: 24.0,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          buildTextField(
                            controller: namaLengkapController,
                            label: 'Nama Lengkap',
                          ),
                          const SizedBox(height: 20),
                          buildTextField(
                            controller: usernameController,
                            label: 'Username',
                          ),
                          const SizedBox(height: 20),
                          buildTextField(
                            controller: emailController,
                            label: 'Email',
                          ),
                          const SizedBox(height: 20),
                          buildTextField(
                            controller: kotaAsalController,
                            label: 'Kota Asal',
                          ),
                          const SizedBox(height: 20),
                          buildTextField(
                            controller: noTelponController,
                            label: 'No Telpon',
                          ),
                          const SizedBox(height: 20),
                          Obx(() => ElevatedButton(
                                onPressed: profileController.isLoading.value
                                    ? null
                                    : () => profileController.updateProfile(
                                          namaLengkap:
                                              namaLengkapController.text,
                                          username: usernameController.text,
                                          email: emailController.text,
                                          kotaAsal: kotaAsalController.text,
                                          noTelpon: noTelponController.text,
                                        ),
                                child: profileController.isLoading.value
                                    ? const CircularProgressIndicator()
                                    : const Text('Save'),
                              )),
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

  Widget buildTextField({
    required TextEditingController controller,
    required String label,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          fontFamily: 'NunitoSans',
          fontWeight: FontWeight.w700,
        ),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
