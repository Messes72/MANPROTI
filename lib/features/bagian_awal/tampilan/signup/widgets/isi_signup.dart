import 'package:flutter/material.dart';
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
            const SizedBox(height: 10.0),

            // Bagian text field
            const SizedBox(
              height: 60.0,
              child: CTextField(label: 'Username'),
            ),
            const SizedBox(
              height: 60.0,
              child: CTextField(label: 'Alamat'),
            ),
            const SizedBox(
              height: 60.0,
              child: CTextField(label: 'Email'),
            ),
            const SizedBox(
              height: 60.0,
              child: CTextField(label: 'No. Telpon'),
            ),
            const SizedBox(
              height: 60.0,
              child: CTextField(label: 'Tanggal Lahir'),
            ),
            const SizedBox(
              height: 60.0,
              child: CTextField(label: 'Password', isPassword: true),
            ),
            const SizedBox(
              height: 60.0,
              child: CTextField(label: 'Re-confirm Password', isPassword: true),
            ),
            Spacer(),

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
    );
  }
}
