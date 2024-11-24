import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manpro/common/widgets/background_app.dart';
import 'package:manpro/navbar.dart';
import 'package:manpro/utils/constants/image_string.dart';

class EventHistory extends StatelessWidget {
  final List<Map<String, String>> eventHistory;
  static final List<Map<String, String>> savedEventHistory = []; // Static list untuk menyimpan history

  EventHistory({super.key, required this.eventHistory}) {
    // Tambahkan event history baru ke savedEventHistory jika belum ada
    if (eventHistory.isNotEmpty) {
      for (var event in eventHistory) {
        if (!savedEventHistory.contains(event)) {
          savedEventHistory.add(event);
        }
      }
    }
  }

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
                    'Event History',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                      fontSize: 24.0,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Expanded(
                    child: savedEventHistory.isEmpty // Gunakan savedEventHistory
                        ? const Center(
                            child: Text(
                              'No event history yet',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: savedEventHistory.length, // Gunakan savedEventHistory
                            itemBuilder: (context, index) {
                              final event = savedEventHistory[index]; // Gunakan savedEventHistory
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
                                      'Event: ${event['eventName'] ?? "Unnamed Event"}',
                                      style: const TextStyle(
                                        fontFamily: 'NunitoSans',
                                        fontWeight: FontWeight.w800,
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Name: ${event['name']}',
                                      style: const TextStyle(
                                        fontFamily: 'NunitoSans',
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Email: ${event['email']}',
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
