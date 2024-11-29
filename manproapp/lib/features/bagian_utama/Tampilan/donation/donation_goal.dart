import 'package:flutter/material.dart';
import 'package:manpro/navbar.dart'; // Assuming this handles your custom navbar logic.
import 'package:manpro/common/widgets/background_app.dart';
import 'package:manpro/utils/constants/image_string.dart';
import 'package:get/get.dart';

class DonationGoal extends StatelessWidget {
  DonationGoal({super.key});
  // Define the list of donation items
  final List<Map<String, dynamic>> items = [
    {
      'name': 'Beras',
      'quantity': '18 kg',
      'target': '10 kg',
      'color': Colors.red[200]!
    },
    {
      'name': 'Buku Tulis',
      'quantity': '178 pcs',
      'target': '200 pcs',
      'color': Colors.green[200]!
    },
    {
      'name': 'Alat Tulis',
      'quantity': '284 pcs',
      'target': '300 pcs',
      'color': Colors.yellow[200]!
    },
    {
      'name': 'Pakaian',
      'quantity': '77 pcs',
      'target': '100 pcs',
      'color': Colors.purple[200]!
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundAPP(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back button navigation
                  IconButton(
                    onPressed: () {
                      final controller = Get.put(NavigationController());
                      controller.selectedIndex.value = 0; // Switch to Home tab
                      Get.off(() => const Navbar()); // Navigate back to Navbar
                    },
                    icon: const ImageIcon(
                      AssetImage(YPKImages.icon_back_button),
                      size: 32.0,
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  const Text(
                    'Donation Gallery',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                      fontSize: 24.0,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  // Expanded list of donation cards
                  Expanded(
                    child: _buildDonationList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build the donation list widget
  Widget _buildDonationList() {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _buildDonationCard(item);
      },
    );
  }

  // Build a single donation card
  Widget _buildDonationCard(Map<String, dynamic> item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: item['color'] as Color,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.pets, size: 40, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  item['name']!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              item['quantity']!,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
            const SizedBox(height: 8),
            const LinearProgressIndicator(
              value: 0.5, // Customize the progress value
              backgroundColor: Colors.white,
              color: Colors.blue,
            ),
            const SizedBox(height: 16),
            // Target label showing the donation target
            Text(
              'Target: ${item['target']}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
