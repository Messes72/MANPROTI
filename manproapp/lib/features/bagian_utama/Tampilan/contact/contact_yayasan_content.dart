import 'package:flutter/material.dart';

class KontakYayasanContent extends StatelessWidget {
  const KontakYayasanContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildContactInfo('Alamat:', 'Jl. Kebahagiaan No. 123, Jakarta'),
          const SizedBox(height: 20.0), // Jarak antar item
          buildContactInfo('Email:', 'panti@contoh.com'),
          const SizedBox(height: 20.0), // Jarak antar item
          buildContactInfo('No Telp:', '+62 812 3456 7890'),
        ],
      ),
    );
  }

  Widget buildContactInfo(String label, String value) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200], // Latar belakang abu-abu terang
        borderRadius: BorderRadius.circular(8.0), // Sudut membulat
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 118, 117, 117),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // Bayangan sedikit ke bawah
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80, // Lebar tetap untuk label agar sejajar
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(width: 8.0), // Spasi antara label dan value
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
