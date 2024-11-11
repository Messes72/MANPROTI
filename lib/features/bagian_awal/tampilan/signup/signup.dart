import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:manpro/common/widgets/background_app.dart';
import 'package:manpro/features/bagian_awal/tampilan/login/login.dart';
import 'package:manpro/features/bagian_awal/tampilan/signup/widgets/signup_logo_app.dart';
import 'package:manpro/features/bagian_awal/tampilan/signup/widgets/signup_tulisan_bawah.dart';
import 'package:manpro/methods/api.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _RegisterState();
}

class _RegisterState extends State<Signup> {

  final String apiUrl = 'http://127.0.0.1:8000/api/register';

  final TextEditingController email = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void registerUser() async {
    if (_formKey.currentState?.validate() ?? false) { // Validasi form
      final data = {
        'email': email.text.trim(),
        'name': username.text.trim(),
        'password': password.text.trim(),
      };

      try {
        // Gunakan API untuk request register
        final result = await API().postRequest(route: 'register', data: data);
        final response = jsonDecode(result.body);

        if (response['status'] == 200) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => Login(),
            ),
          );
        } else {
          // Tampilkan pesan error jika pendaftaran gagal
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response['message'] ?? 'Terjadi kesalahan')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal terhubung ke server.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundAPP(),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Column(
                  children: [
                    const SignupLogoApp(),
                    InkWell(
                      onTap: registerUser, // Panggil registerUser saat tombol ditekan
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                        height: 300.0,
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
                          padding: const EdgeInsets.fromLTRB(15.0, 13.0, 13.0, 15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontFamily: 'NunitoSans',
                                  fontWeight: FontWeight.w800,
                                  fontSize: 20.0,
                                ),
                              ),
                              Form(
                                key: _formKey, // Tambahkan key untuk form
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextFormField(
                                      controller: username, // Hubungkan controller
                                      decoration: const InputDecoration(
                                        labelText: 'Username',
                                        labelStyle: TextStyle(
                                            fontFamily: 'NunitoSans',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.0),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Username tidak boleh kosong';
                                        }
                                        return null;
                                      },
                                    ),
                                    TextFormField(
                                      controller: email, // Hubungkan controller
                                      decoration: const InputDecoration(
                                        labelText: 'Email',
                                        labelStyle: TextStyle(
                                            fontFamily: 'NunitoSans',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.0),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Email tidak boleh kosong';
                                        }
                                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                                          return 'Email tidak valid';
                                        }
                                        return null;
                                      },
                                    ),
                                    TextFormField(
                                      controller: password, // Hubungkan controller
                                      decoration: const InputDecoration(
                                        labelText: 'Password',
                                        labelStyle: TextStyle(
                                            fontFamily: 'NunitoSans',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.0),
                                      ),
                                      obscureText: true,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Password tidak boleh kosong';
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 170.0,
                                child: ElevatedButton(
                                  onPressed: registerUser, // Panggil registerUser saat tombol ditekan
                                  child: const Text(
                                    'Confirm',
                                    style: TextStyle(
                                      fontFamily: 'NunitoSans',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    SignupTulisanBawah(),
                    const SizedBox(height: 100.0),
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
