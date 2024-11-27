import 'package:flutter/material.dart';

class KontakYayasanContent extends StatelessWidget {
  const KontakYayasanContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 6,
            blurRadius: 7,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildContactInfo('Alamat:', 'Jl. Kebahagiaan No. 123, Jakarta'),
            const SizedBox(height: 15.0),
            buildContactInfo('Email:', 'panti@contoh.com'),
            const SizedBox(height: 15.0),
            buildContactInfo('No Telp:', '+62 812 3456 7890'),
          ],
        ),
      ),
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
            fontFamily: 'NunitoSans',
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 18.0,
              fontFamily: 'NunitoSans',
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
