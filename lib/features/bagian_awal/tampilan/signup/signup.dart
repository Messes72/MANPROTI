import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:manpro/common/widgets/background_app.dart';
import 'package:manpro/features/bagian_awal/tampilan/login/login.dart';

// import 'package:manpro/features/bagian_awal/tampilan/signup/widgets/isi_signup.dart';
import 'package:manpro/features/bagian_awal/tampilan/signup/widgets/signup_logo_app.dart';
import 'package:manpro/features/bagian_awal/tampilan/signup/widgets/signup_tulisan_bawah.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

//   @override
//   State<Signup> createState() => _RegisterState();
// }
//
// class _RegisterState extends State<Signup> {
//   TextEditingController email = TextEditingController();
//   TextEditingController username = TextEditingController();
//   TextEditingController password = TextEditingController();
//
//   void registerUser() async {
//     final data = {
//       'email': email.text.toString(),
//       'name': username.text.toString(),
//       'password': password.text.toString(),
//     };
//     final result = await API().postRequest(route: '/register', data: data);
//     final response = jsonDecode(result.body);
//     if (response['status'] == 200) {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(
//           builder: (context) => Login(),
//         ),
//       );
//     }
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Bagian bg app
          const BackgroundAPP(),

          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Column(
                  children: [
                    // Bagian logo app
                    const SignupLogoApp(),

                    // Bagian signup
                    Container(
                      margin: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                      // height: 550.0,
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
                        padding:
                            const EdgeInsets.fromLTRB(15.0, 13.0, 13.0, 15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Bagian tulisan login
                            const Text(
                              'Sign Up',
                              style: TextStyle(
                                fontFamily: 'NunitoSans',
                                fontWeight: FontWeight.w800,
                                fontSize: 20.0,
                              ),
                            ),

                            // Bagian text field
                            Form(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      labelText: 'Username',
                                      labelStyle: TextStyle(
                                          fontFamily: 'NunitoSans',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.0),
                                    ),
                                  ),
                                  // TextFormField(
                                  //   decoration: const InputDecoration(
                                  //     labelText: 'Alamat',
                                  //     labelStyle: TextStyle(
                                  //         fontFamily: 'NunitoSans',
                                  //         fontWeight: FontWeight.w500,
                                  //         fontSize: 14.0),
                                  //   ),
                                  // ),
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      labelText: 'Email',
                                      labelStyle: TextStyle(
                                          fontFamily: 'NunitoSans',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.0),
                                    ),
                                  ),
                                  // TextFormField(
                                  //   decoration: const InputDecoration(
                                  //     labelText: 'No. Telpon',
                                  //     labelStyle: TextStyle(
                                  //         fontFamily: 'NunitoSans',
                                  //         fontWeight: FontWeight.w500,
                                  //         fontSize: 14.0),
                                  //   ),
                                  // ),
                                  // TextFormField(
                                  //   decoration: const InputDecoration(
                                  //     labelText: 'Tanggal Lahir',
                                  //     labelStyle: TextStyle(
                                  //         fontFamily: 'NunitoSans',
                                  //         fontWeight: FontWeight.w500,
                                  //         fontSize: 14.0),
                                  //   ),
                                  // ),
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      labelText: 'Password',
                                      labelStyle: TextStyle(
                                          fontFamily: 'NunitoSans',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.0),
                                    ),
                                  ),
                                  // TextFormField(
                                  //   decoration: const InputDecoration(
                                  //     labelText: 'Re-confirm Password',
                                  //     labelStyle: TextStyle(
                                  //         fontFamily: 'NunitoSans',
                                  //         fontWeight: FontWeight.w500,
                                  //         fontSize: 14.0),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),

                            // Bagian tombol
                            SizedBox(
                              width: 170.0,
                              child: ElevatedButton(
                                onPressed: () {},
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
                    SizedBox(height: 20.0),

                    // Bagian tulisan bawah
                    SignupTulisanBawah(),
                    SizedBox(height: 100.0)
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
