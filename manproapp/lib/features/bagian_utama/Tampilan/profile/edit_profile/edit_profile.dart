import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manpro/common/widgets/background_app.dart';
import 'package:manpro/features/bagian_utama/Tampilan/profile/profile.dart';
import 'package:manpro/utils/constants/image_string.dart';

class EditProfile extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;

  const EditProfile({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    final firstNameController = TextEditingController(text: firstName);
    final lastNameController = TextEditingController(text: lastName);
    final emailController = TextEditingController(text: email);
    final phoneNumberController = TextEditingController(text: phoneNumber);

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
                          TextField(
                            controller: firstNameController,
                            decoration: const InputDecoration(
                              labelText: 'First Name',
                              labelStyle: TextStyle(
                                fontFamily: 'NunitoSans',
                                fontWeight: FontWeight.w700,
                              ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: lastNameController,
                            decoration: const InputDecoration(
                              labelText: 'Last Name',
                              labelStyle: TextStyle(
                                fontFamily: 'NunitoSans',
                                fontWeight: FontWeight.w700,
                              ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                fontFamily: 'NunitoSans',
                                fontWeight: FontWeight.w700,
                              ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: phoneNumberController,
                            decoration: const InputDecoration(
                              labelText: 'Phone Number',
                              labelStyle: TextStyle(
                                fontFamily: 'NunitoSans',
                                fontWeight: FontWeight.w700,
                              ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context, {
                                'firstName': firstNameController.text,
                                'lastName': lastNameController.text,
                                'email': emailController.text,
                                'phoneNumber': phoneNumberController.text,
                              });
                            },
                            child: const Text(
                              'Save',
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
            ),
          ),
        ],
      ),
    );
  }
}

