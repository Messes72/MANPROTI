import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'package:manpro/navbar.dart';
import 'package:manpro/common/widgets/background_app.dart';
import 'package:manpro/utils/constants/image_string.dart';
import '../../../Controllers/donation_goal_controller.dart';

class DonationGoal extends StatelessWidget {
  DonationGoal({super.key});

  final DonationGoalController controller = Get.put(DonationGoalController());
  final Random _random = Random();

  // List warna pastel yang bisa dipilih secara random
  final List<Color> _pastelColors = [
    const Color(0xFFFFB5B5), // Merah muda
    const Color(0xFFA8E6CF), // Hijau mint
    const Color(0xFFFFE3B3), // Kuning
    const Color(0xFFD4B5FF), // Ungu muda
    const Color(0xFFB5D8FF), // Biru muda
    const Color(0xFFFFC8A2), // Peach
    const Color(0xFFE5B5FF), // Pink muda
    const Color(0xFFB5FFD9), // Mint muda
    const Color(0xFFFFB5E5), // Pink tua
    const Color(0xFFB5FFFF), // Cyan muda
  ];

  // Map untuk menyimpan warna yang sudah di-assign ke tipe donasi
  final Map<String, Color> _typeColors = {};

  Color _getColorForType(String type) {
    // Jika tipe sudah punya warna, gunakan warna yang sama
    if (_typeColors.containsKey(type)) {
      return _typeColors[type]!;
    }

    // Jika belum, pilih warna random dari list yang tersedia
    Color newColor = _pastelColors[_random.nextInt(_pastelColors.length)];

    // Pastikan warna belum digunakan (jika masih ada warna yang tersedia)
    if (_typeColors.values.length < _pastelColors.length) {
      while (_typeColors.values.contains(newColor)) {
        newColor = _pastelColors[_random.nextInt(_pastelColors.length)];
      }
    }

    // Simpan warna untuk tipe ini
    _typeColors[type] = newColor;
    return newColor;
  }

  void _navigateToDonation(String type) {
    Get.toNamed('/donation', arguments: {'type': type});
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
                      controller.selectedIndex.value = 0;
                      Get.to(() => const Navbar());
                    },
                    icon: const ImageIcon(
                      AssetImage(YPKImages.icon_back_button),
                      size: 32.0,
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  const Text(
                    'Report',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                      fontSize: 24.0,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Expanded(
                    child: Obx(() {
                      if (controller.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (controller.error.isNotEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(controller.error.value),
                              ElevatedButton(
                                onPressed: () =>
                                    controller.fetchDonationGoals(),
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        );
                      }

                      if (controller.goals.isEmpty) {
                        return const Center(
                            child: Text('No donation goals available'));
                      }

                      return ListView.builder(
                        itemCount: controller.goals.length,
                        itemBuilder: (context, index) {
                          final goal = controller.goals[index];
                          final cardColor = _getColorForType(goal.type);

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: cardColor,
                                borderRadius: BorderRadius.circular(25.0),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2.0,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 80,
                                                height: 80,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.5,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Image.asset(
                                                    YPKImages.icon_back_button,
                                                    width: 24,
                                                    height: 24,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 20),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      goal.type,
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Text(
                                                      '${goal.currentQuantity}/${goal.targetQuantity}',
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black87,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: LinearProgressIndicator(
                                        value: goal.percentage / 100,
                                        backgroundColor:
                                            Colors.white.withOpacity(0.5),
                                        valueColor:
                                            const AlwaysStoppedAnimation<Color>(
                                          Colors.black,
                                        ),
                                        minHeight: 8,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () =>
                                                _navigateToDonation(goal.type),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                              foregroundColor: Colors.black,
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                side: const BorderSide(
                                                  color: Colors.black,
                                                  width: 1.5,
                                                ),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 12,
                                              ),
                                            ),
                                            child: const Text(
                                              'Donate',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
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
