import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manpro/features/bagian_awal/tampilan/forget_password/widgets/fp_form.dart';
import 'package:manpro/features/bagian_awal/tampilan/resubmission_password/resubmission_password.dart';

class IsiFp extends StatelessWidget {
  const IsiFp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
      height: 230.0,
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Masukkan Email/No.Telpon',
                      labelStyle: TextStyle(
                          fontFamily: 'NunitoSans',
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),

            // Bagian tombol
            SizedBox(
              width: 170.0,
              child: ElevatedButton(
                onPressed: () => Get.to(() => const ResubmissionPassword()),
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
