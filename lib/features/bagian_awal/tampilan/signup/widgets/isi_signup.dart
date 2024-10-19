import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manpro/features/bagian_awal/tampilan/login/login.dart';
import 'package:manpro/features/bagian_awal/tampilan/signup/widgets/signup_form.dart';

class IsiSignup extends StatelessWidget {
  const IsiSignup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
      height: 550.0,
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Alamat',
                      labelStyle: TextStyle(
                          fontFamily: 'NunitoSans',
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0),
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                          fontFamily: 'NunitoSans',
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0),
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'No. Telpon',
                      labelStyle: TextStyle(
                          fontFamily: 'NunitoSans',
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0),
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Tanggal Lahir',
                      labelStyle: TextStyle(
                          fontFamily: 'NunitoSans',
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0),
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(
                          fontFamily: 'NunitoSans',
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0),
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Re-confirm Password',
                      labelStyle: TextStyle(
                          fontFamily: 'NunitoSans',
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0),
                    ),
                  ),
                ],
              ),
            ),

            // Bagian tombol
            SizedBox(
              width: 170.0,
              child: ElevatedButton(
                onPressed: () => Get.to(() => const Login()),
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
    );
  }
}
