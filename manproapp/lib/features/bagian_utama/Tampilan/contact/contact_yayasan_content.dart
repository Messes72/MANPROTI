import 'package:flutter/material.dart';

class KontakYayasanContent extends StatelessWidget {
  const KontakYayasanContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildContactInfo('Alamat:', 'Jl. Kebahagiaan No. 123, Jakarta'),
        const SizedBox(height: 15.0),
        buildContactInfo('Email:', 'panti@contoh.com'),
        const SizedBox(height: 15.0),
        buildContactInfo('No Telp:', '+62 812 3456 7890'),
      ],
    );
  }

  Widget buildContactInfo(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'lorem ipsum',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
