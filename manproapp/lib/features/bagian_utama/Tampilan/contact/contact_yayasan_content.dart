import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manpro/features/bagian_utama/controllers/contactController.dart';

class ContactYayasanContent extends StatelessWidget {
  ContactYayasanContent({super.key});

  final ContactController contactController = Get.put(ContactController());

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
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
=======
    return Obx(() {
      if (contactController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final contact = contactController.contact.value;
      if (contact == null) {
        return const Center(child: Text('Tidak ada data kontak'));
      }

      return Column(
        children: [
          // Alamat
          _buildContactItem(
            icon: Icons.location_on,
            title: 'Alamat',
            content: contact.alamat,
          ),
          const SizedBox(height: 20),

          // Email
          _buildContactItem(
            icon: Icons.email,
            title: 'Email',
            content: contact.email,
          ),
          const SizedBox(height: 20),

          // Nomor Telepon
          _buildContactItem(
            icon: Icons.phone,
            title: 'Nomor Telepon',
            content: contact.noTelp,
          ),
        ],
      );
    });
  }

  Widget _buildContactItem({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 143, 143, 143).withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue, size: 24),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontFamily: 'NunitoSans',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  content,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    fontFamily: 'NunitoSans',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
>>>>>>> def64f356d344a2d80879ba2ca06edb5c05023c7
}
