import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:manpro/features/bagian_utama/Tampilan/profile_yayasan/widgets/tombol_back.dart';
import 'package:manpro/features/bagian_utama/Tampilan/report/review.dart';

class ReportApp extends StatelessWidget {
  const ReportApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Donation Report',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const ReportPage(),
    );
  }
}

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade100,
        elevation: 0,
        leading: TombolBack(),
        title: const Text('Report', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink.shade100, Colors.blue.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            DonationCard(
              color: Colors.red.shade200,
              icon: Icons.local_dining,
              title: 'Beras',
              quantity: '18 kg',
              progress: 0.3,
            ),
            const SizedBox(height: 16.0),
            DonationCard(
              color: Colors.green.shade200,
              icon: Icons.book,
              title: 'Buku Tulis',
              quantity: '178 pcs',
              progress: 0.5,
            ),
            const SizedBox(height: 16.0),
            DonationCard(
              color: Colors.yellow.shade200,
              icon: Icons.edit,
              title: 'Alat Tulis',
              quantity: '284 pcs',
              progress: 0.7,
            ),
            const SizedBox(height: 16.0),
            DonationCard(
              color: Colors.purple.shade200,
              icon: Icons.checkroom,
              title: 'Pakaian',
              quantity: '77 pcs',
              progress: 0.4,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.forum), label: 'Forums'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Profile Yayasan'),
          BottomNavigationBarItem(icon: Icon(Icons.contact_mail), label: 'Contact'),
          BottomNavigationBarItem(icon: Icon(Icons.photo_library), label: 'Gallery'),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

class DonationCard extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;
  final String quantity;
  final double progress;

  const DonationCard({
    required this.color,
    required this.icon,
    required this.title,
    required this.quantity,
    required this.progress,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 40.0),
              const SizedBox(width: 16.0),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                quantity,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey.shade300,
            color: Colors.blue,
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {},
                child: const Text('Donate'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () => Get.to(() => ReportReviewPage()),
                child: const Text('Review'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
