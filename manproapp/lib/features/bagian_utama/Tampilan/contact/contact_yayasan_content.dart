import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manpro/features/bagian_utama/controllers/contactController.dart';

class ContactYayasanContent extends StatelessWidget {
  ContactYayasanContent({super.key});

  final ContactController contactController = Get.put(ContactController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (contactController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final contact = contactController.contact.value;
      if (contact == null) {
        return const Center(child: Text('Tidak ada data kontak'));
      }

      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
        ),
      );
    });
  }

  Widget _buildContactItem({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 118, 117, 117),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
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
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  content,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
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
}
