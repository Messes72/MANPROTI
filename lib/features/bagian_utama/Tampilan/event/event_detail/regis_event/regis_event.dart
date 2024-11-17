import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manpro/common/widgets/background_app.dart';
import 'package:manpro/features/bagian_utama/Tampilan/event_history/event_history.dart';
import 'package:manpro/navbar.dart';
import 'package:manpro/utils/constants/image_string.dart';

class RegisEvent extends StatefulWidget {
  final String eventName;
  const RegisEvent({super.key, required this.eventName});

  @override
  State<RegisEvent> createState() => _RegisEventState();
}

class _RegisEventState extends State<RegisEvent> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  // List untuk menyimpan history event
  static final List<Map<String, String>> eventHistoryList = [];

  void _submitRegistration() {
    if (nameController.text.isEmpty || emailController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all fields',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.only(bottom: 15.0, left: 20.0, right: 20.0),
      );
      return;
    }

    // Create registration data
    final Map<String, String> registrationData = {
      'eventName': widget.eventName,
      'name': nameController.text,
      'email': emailController.text,
    };

    // Tambahkan data ke list history
    eventHistoryList.add(registrationData);

    // Navigate back to Navbar and switch to Event History tab
    Get.offAll(
      () => EventHistory(eventHistory: eventHistoryList),
      binding: BindingsBuilder(() {
        final controller = Get.put(NavigationController());
        controller.selectedIndex.value = 3; // Switch to History tab
      }),
    );

    Get.snackbar(
      'Success',
      'Registration submitted successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      margin: const EdgeInsets.only(bottom: 15.0, left: 20.0, right: 20.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundAPP(),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () => Get.to(() => const Navbar()),
                      icon: const ImageIcon(
                        AssetImage(YPKImages.icon_back_button),
                        size: 32.0,
                      ),
                    ),
                    const SizedBox(height: 25.0),
                    const Text(
                      'Daftar Event',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        fontSize: 24.0,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
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
                            'Event: ${widget.eventName}',
                            style: const TextStyle(
                              fontFamily: 'NunitoSans',
                              fontWeight: FontWeight.w800,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                              hintText: 'Name',
                              hintStyle: const TextStyle(
                                fontFamily: 'NunitoSans',
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF333333),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: const TextStyle(
                                fontFamily: 'NunitoSans',
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF333333),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                            ),
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _submitRegistration,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFF7ABFB),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(
                                      color: Colors.black, width: 1.5),
                                ),
                              ),
                              child: const Text(
                                'Confirm',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
