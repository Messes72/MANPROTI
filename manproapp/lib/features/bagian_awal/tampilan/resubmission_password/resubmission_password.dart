import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manpro/common/widgets/background_app.dart';
import 'package:manpro/features/bagian_awal/controllers/authenticationController.dart';
import 'package:manpro/features/bagian_awal/tampilan/login/login.dart';
import 'package:manpro/features/bagian_awal/tampilan/resubmission_password/widgets/isi_rsp.dart';
import 'package:manpro/utils/constants/image_string.dart';

class ResubmissionPassword extends StatefulWidget {
  const ResubmissionPassword({super.key});

  @override
  State<ResubmissionPassword> createState() => _ResubmissionPasswordState();
}

class _ResubmissionPasswordState extends State<ResubmissionPassword> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Bagian bg app
          const BackgroundAPP(),

          // Bagian isi tampilan
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Column(
                  children: [
                    // Gambar logo
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0),
                      child: Transform.scale(
                        scale: 1.2,
                        child: const Image(
                          height: 300.0,
                          image: AssetImage(YPKImages.logo),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    // Bagian login
                    Container(
                      margin: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                      height: 260.0,
                      decoration: BoxDecoration(
                        color: Colors.indigo[100],
                        borderRadius: BorderRadius.circular(40.0),
                        border: Border.all(
                          color: Colors.black.withOpacity(0.4),
                          width: 1.8,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3.0,
                            blurRadius: 3.0,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(15.0, 13.0, 13.0, 15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Bagian tulisan login
                            const Text(
                              'Forget Password',
                              style: TextStyle(
                                fontFamily: 'NunitoSans',
                                fontWeight: FontWeight.w800,
                                fontSize: 20.0,
                              ),
                            ),
                            const SizedBox(height: 10.0),

                            // Bagian text field
                            Form(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IsiRsp(
                                    labelText: 'Masukkan password baru',
                                    controller: _passwordController,
                                  ),
                                  IsiRsp(
                                    labelText: 'Konfirmasi password baru',
                                    controller: _confirmPasswordController,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10.0),

                            // Bagian tombol
                            SizedBox(
                              width: 170.0,
                              child: Obx(() {
                                return _authenticationController.isLoading.value
                                    ? const CircularProgressIndicator()
                                    : ElevatedButton(
                                        onPressed: () {
                                          if (_passwordController
                                                  .text.isEmpty ||
                                              _confirmPasswordController
                                                  .text.isEmpty) {
                                            Get.snackbar('Error',
                                                'Password tidak boleh kosong',
                                                margin: const EdgeInsets.only(
                                                    bottom: 10.0),
                                                snackPosition:
                                                    SnackPosition.TOP,
                                                backgroundColor: Colors.red,
                                                colorText: Colors.white);
                                            return;
                                          }

                                          if (_passwordController.text !=
                                              _confirmPasswordController.text) {
                                            Get.snackbar(
                                                'Error', 'Password tidak sama',
                                                margin: const EdgeInsets.only(
                                                    bottom: 10.0),
                                                snackPosition:
                                                    SnackPosition.TOP,
                                                backgroundColor: Colors.red,
                                                colorText: Colors.white);
                                            return;
                                          }

                                          _authenticationController
                                              .forgetPassword(
                                            email: Get.arguments['email'],
                                            password: _passwordController.text.trim(),
                                            password_confirmation:
                                                _confirmPasswordController.text.trim(),
                                          );
                                        },
                                        child: const Text(
                                          'Confirm',
                                          style: TextStyle(
                                            fontFamily: 'NunitoSans',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                      );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),

                    // Bagian tulisan bawah
                    Container(
                      margin: const EdgeInsets.only(left: 30.0),
                      child: Row(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () => Get.to(() => const Login()),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[200],
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4.0),
                              minimumSize: const Size(120, 40),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            icon: const Icon(Icons.arrow_back,
                                color: Colors.white),
                            label: const Text(
                              'Cancel',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'NunitoSans',
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                                letterSpacing: -0.5,
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
