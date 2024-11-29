import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:manpro/features/bagian_utama/Tampilan/donation/donation_goal.dart';
import 'package:manpro/features/bagian_utama/Tampilan/profile_yayasan/widgets/tombol_back.dart';

class DonationGallery extends StatelessWidget {
  DonationGallery({super.key});

  // List nama file gambar dari folder assets
  final List<String> donationImages = [
    'assets/images/event1.jpg',
    'assets/images/event2.jpg',
    'assets/images/event3.jpg',
    // Tambahkan file lainnya di sini
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donation Gallery'),
        leading: const TombolBack(),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9, // Lebar lebih kecil
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(
                    color: Colors.grey.shade400,
                    width: 2.0, // Ketebalan border keseluruhan
                  ),
                ),
                padding: const EdgeInsets.all(12.0), // Padding di dalam galeri
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Jumlah kolom
                    crossAxisSpacing: 8.0, // Jarak horizontal antar kolom
                    mainAxisSpacing: 8.0, // Jarak vertikal antar kolom
                    childAspectRatio: 3 / 4, // Rasio gambar (lebih ramping)
                  ),
                  itemCount: donationImages.length,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12.0), // Membulatkan gambar
                      child: Image.asset(
                        donationImages[index],
                        fit: BoxFit.cover,
                        width: 100, // Ukuran gambar lebih kecil
                        height: 100,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          // Tombol Goal di bawah
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0), // Jarak tombol
            child: ElevatedButton(
              onPressed: () =>
                Get.to(() => DonationGoal()), // Pindah ke halaman Goal
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange, // Warna tombol
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0), // Ukuran tombol
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0), // Membulatkan tombol
                ),
              ),
              child: const Text(
                'Goal',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold), // Gaya teks tombol
              ),
            ),
          ),
        ],
      ),
    );
  }
}
