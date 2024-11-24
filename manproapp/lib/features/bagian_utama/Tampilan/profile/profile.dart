import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manpro/common/widgets/background_app.dart';
import 'package:manpro/features/bagian_utama/Tampilan/profile/edit_profile/edit_profile.dart';
import 'package:manpro/navbar.dart';
import 'package:manpro/utils/constants/image_string.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String firstName = "Jehezkiel";
  String lastName = "Louis";
  String email = "jehezkiel@gmail.com";
  String phoneNumber = "08178787878";

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
                              firstName,
                              const TextStyle(
                                  fontFamily: "NunitoSans",
                                  fontWeight: FontWeight.w700)),
                          buildProfileField(
                              lastName,
                              const TextStyle(
                                  fontFamily: "NunitoSans",
                                  fontWeight: FontWeight.w700)),
                          buildProfileField(
                              email,
                              const TextStyle(
                                  fontFamily: "NunitoSans",
                                  fontWeight: FontWeight.w700)),
                          buildProfileField(
                              phoneNumber,
                              const TextStyle(
                                  fontFamily: "NunitoSans",
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  final result = await Get.to(() => EditProfile(
                                        firstName: firstName,
                                        lastName: lastName,
                                        email: email,
                                        phoneNumber: phoneNumber,
                                      ));
                                  if (result != null) {
                                    bool isUpdated = false;
                                    setState(() {
                                      if (firstName != result['firstName']) {
                                        firstName = result['firstName'];
                                        isUpdated = true;
                                      }
                                      if (lastName != result['lastName']) {
                                        lastName = result['lastName'];
                                        isUpdated = true;
                                      }
                                      if (email != result['email']) {
                                        email = result['email'];
                                        isUpdated = true;
                                      }
                                      if (phoneNumber !=
                                          result['phoneNumber']) {
                                        phoneNumber = result['phoneNumber'];
                                        isUpdated = true;
                                      }
                                    });
                                    if (isUpdated) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Profile updated successfully!'),
                                          backgroundColor: Colors.green,
                                          behavior: SnackBarBehavior.floating,
                                          margin: EdgeInsets.only(bottom: 10.0),
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: const Text(
                                  'Edit profile',
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
