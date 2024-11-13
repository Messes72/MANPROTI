import 'package:flutter/material.dart';
import 'package:manpro/features/bagian_utama/Tampilan/profile_yayasan/widgets/tombol_back.dart';

class DonationApp extends StatelessWidget {
  const DonationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Donation App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const DonationForm(),
    );
  }
}

class DonationForm extends StatelessWidget {
  const DonationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade100,
        elevation: 0,
        leading: TombolBack(),
        title: const Text('Donation', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink.shade100, Colors.blue.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.pink.shade200,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: const Text(
                'Category',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: 'Pilih Jenis Donasi',
              ),
              items: const [
                DropdownMenuItem(value: 'Food', child: Text('Food')),
                DropdownMenuItem(value: 'Clothes', child: Text('Clothes')),
                DropdownMenuItem(value: 'Medicine', child: Text('Medicine')),
              ],
              onChanged: (value) {},
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Quantity (example : 10kg, 10pcs, etc)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Notes',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: 'Pilih Pengiriman',
              ),
              items: const [
                DropdownMenuItem(value: 'Self Delivery', child: Text('Self Delivery')),
                DropdownMenuItem(value: 'Courier', child: Text('Courier')),
              ],
              onChanged: (value) {},
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: const BorderSide(color: Colors.black),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
              ),
              onPressed: () {},
              child: const Text('Confirm'),
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
