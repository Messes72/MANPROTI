import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manpro/common/widgets/background_app.dart';
import 'package:manpro/navbar.dart';
import 'package:manpro/utils/constants/image_string.dart';
import 'package:manpro/features/bagian_utama/controllers/donationController.dart';
import 'package:manpro/features/bagian_utama/Tampilan/donation_history/donation_history.dart';
import 'package:manpro/features/bagian_utama/models/donationModel.dart';

class Donation extends StatefulWidget {
  const Donation({super.key});

  @override
  State<Donation> createState() => _DonationState();
}

class _DonationState extends State<Donation> {
  // ===== CONTROLLERS & VARIABLES =====
  final DonationController donationController = Get.put(DonationController());
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final FocusNode quantityFocus = FocusNode();
  final FocusNode notesFocus = FocusNode();

  String? selectedDonationType;
  String? selectedShippingMethod;
  bool isSubmitting = false;

  // ===== LIFECYCLE METHODS =====
  @override
  void initState() {
    super.initState();
    // Load donation types and shipping methods when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      donationController.getDonationTypes();
      donationController.getShippingMethods();
    });
  }

  @override
  void dispose() {
    // Clean up controllers when screen is closed
    quantityController.dispose();
    notesController.dispose();
    quantityFocus.dispose();
    notesFocus.dispose();
    super.dispose();
  }

  // ===== HELPER FUNCTIONS =====
  bool _validateQuantity(String value) {
    if (value.isEmpty) return false;

    // First check if it's just a number
    if (RegExp(r'^\d+$').hasMatch(value)) {
      return true;
    }

    // If not just a number, check if it has valid unit
    final RegExp quantityRegex = RegExp(
        r'^\d+\s*(kg|pcs|items?|box(es)?|pack(s)?|buah|lembar|pasang|set)$',
        caseSensitive: false);
    return quantityRegex.hasMatch(value);
  }

  // ===== FORM SUBMISSION =====
  void _submitDonation() async {
    // Prevent double submission
    if (isSubmitting) return;

    // Check if all fields are filled
    if (selectedDonationType == null ||
        selectedShippingMethod == null ||
        quantityController.text.isEmpty ||
        notesController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all fields',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.only(bottom: 15.0, left: 20.0, right: 20.0),
      );
      return;
    }

    // Validate quantity format
    if (!_validateQuantity(quantityController.text)) {
      Get.snackbar(
        'Error',
        'Please enter valid quantity (e.g., 10, 5pcs, 3kg, 2box)',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Check notes length
    if (notesController.text.length > 500) {
      Get.snackbar(
        'Error',
        'Notes cannot exceed 500 characters',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Start submission
    setState(() => isSubmitting = true);

    try {
      // Create donation
      await donationController.createDonation(
        DonationModel(
          type: selectedDonationType!,
          quantity: quantityController.text,
          shippingMethod: selectedShippingMethod!,
          notes: notesController.text,
        ),
      );

      // Navigate to history screen after successful submission
      Get.off(() => DonationHistory());
    } finally {
      setState(() => isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // Show confirmation dialog when trying to leave with unsaved changes
      onWillPop: () async {
        bool hasChanges = quantityController.text.isNotEmpty ||
            notesController.text.isNotEmpty ||
            selectedDonationType != null ||
            selectedShippingMethod != null;

        if (!hasChanges) return true;

        final result = await Get.dialog<bool>(
          AlertDialog(
            title: const Text(
              'Discard Changes?',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w700,
              ),
            ),
            content: const Text(
              'Are you sure you want to discard your donation form?',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w700,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Get.back(result: false),
                child: const Text(
                  'No',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Get.back(result: true),
                child: const Text(
                  'Yes',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        );
        return result ?? false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            // Background
            const BackgroundAPP(),

            // Main Content
            SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Back Button
                      IconButton(
                        onPressed: () async {
                          bool hasChanges =
                              quantityController.text.isNotEmpty ||
                                  notesController.text.isNotEmpty ||
                                  selectedDonationType != null ||
                                  selectedShippingMethod != null;

                          if (!hasChanges) {
                            Get.to(() => const Navbar());
                            return;
                          }

                          final result = await Get.dialog<bool>(
                            AlertDialog(
                              title: const Text('Discard Changes?'),
                              content: const Text(
                                  'Are you sure you want to discard your donation form?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Get.back(result: false),
                                  child: const Text('No'),
                                ),
                                TextButton(
                                  onPressed: () => Get.back(result: true),
                                  child: const Text('Yes'),
                                ),
                              ],
                            ),
                          );
                          if (result ?? false) {
                            Get.to(() => const Navbar());
                          }
                        },
                        icon: const ImageIcon(
                          AssetImage(YPKImages.icon_back_button),
                          size: 32.0,
                        ),
                      ),

                      const SizedBox(height: 25.0),

                      // Title
                      const Text(
                        'Donations',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                          fontSize: 24.0,
                          letterSpacing: -0.5,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Form Container
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
                            // Category Header
                            Container(
                              height: 60.0,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF7ABFB),
                                borderRadius: BorderRadius.circular(27),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2.0,
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  'Category',
                                  style: TextStyle(
                                    fontSize: 23,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Donation Type Dropdown
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                hintText: 'Pilih Jenis Donasi',
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
                              value: selectedDonationType,
                              items: donationController.donationTypes
                                  .map((type) => DropdownMenuItem<String>(
                                        value: type.name,
                                        child: Text(type.name),
                                      ))
                                  .toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedDonationType = newValue;
                                });
                              },
                            ),

                            const SizedBox(height: 20),

                            // Quantity Input
                            TextFormField(
                              controller: quantityController,
                              focusNode: quantityFocus,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) {
                                notesFocus.requestFocus();
                              },
                              decoration: InputDecoration(
                                hintText:
                                    'Quantity (example: 10kg, 10pcs, etc)',
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

                            // Notes Input
                            TextFormField(
                              controller: notesController,
                              focusNode: notesFocus,
                              maxLines: 3,
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (_) {
                                notesFocus.unfocus();
                              },
                              decoration: InputDecoration(
                                hintText: 'Notes',
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

                            // Shipping Method Dropdown
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                hintText: 'Pilih Pengiriman',
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
                              value: selectedShippingMethod,
                              items: donationController.shippingMethods
                                  .map((method) => DropdownMenuItem<String>(
                                        value: method.name,
                                        child: Text(method.name),
                                      ))
                                  .toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedShippingMethod = newValue;
                                });
                              },
                            ),

                            const SizedBox(height: 30),

                            // Submit Button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed:
                                    isSubmitting ? null : _submitDonation,
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
                                child: isSubmitting
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.black),
                                        ),
                                      )
                                    : const Text(
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
      ),
    );
  }
}
