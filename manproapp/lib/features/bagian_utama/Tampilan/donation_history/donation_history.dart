import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manpro/common/widgets/background_app.dart';
import 'package:manpro/navbar.dart';
import 'package:manpro/utils/constants/image_string.dart';

class DonationHistory extends StatelessWidget {
  DonationHistory({super.key});

  final List<Map<String, String>> donationHistory = Get.arguments ?? [];

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
                  IconButton(
                    onPressed: () {
                      final controller = Get.put(NavigationController());
                      controller.selectedIndex.value = 0; // Switch to Home tab
                      Get.to(() => const Navbar());
                    },
                    icon: const ImageIcon(
                      AssetImage(YPKImages.icon_back_button),
                      size: 32.0,
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  const Text(
                    'Donation History',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                      fontSize: 24.0,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Expanded(
                    child: donationHistory.isEmpty
                        ? const Center(
                            child: Text(
                              'No donation history yet',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: donationHistory.length,
                            itemBuilder: (context, index) {
                              final donation = donationHistory[index];
                              return Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 3,
                                      blurRadius: 7,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Type: ${donation['type']}',
                                      style: const TextStyle(
                                        fontFamily: 'NunitoSans',
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Quantity: ${donation['quantity']}',
                                      style: const TextStyle(
                                        fontFamily: 'NunitoSans',
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Shipping Method: ${donation['shippingMethod']}',
                                      style: const TextStyle(
                                        fontFamily: 'NunitoSans',
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Notes: ${donation['notes']}',
                                      style: const TextStyle(
                                        fontFamily: 'NunitoSans',
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
