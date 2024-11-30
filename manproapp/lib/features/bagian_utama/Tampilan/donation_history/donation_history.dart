import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manpro/common/widgets/background_app.dart';
import 'package:manpro/navbar.dart';
import 'package:manpro/utils/constants/image_string.dart';
import 'package:manpro/features/bagian_utama/controllers/donationController.dart';

class DonationHistory extends StatelessWidget {
  // ===== CONTROLLER =====
  final DonationController donationController = Get.put(DonationController());

  DonationHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          const BackgroundAPP(),

          // Main Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back Button
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

                  // Page Title
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

                  // Donation List with Pull to Refresh
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => donationController.getDonations(),
                      child: Obx(() {
                        // Show loading indicator while fetching data
                        if (donationController.isLoading.value) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        // Show error message if there's an error
                        if (donationController.hasError.value) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  donationController.errorMessage.value,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 16,
                                    fontFamily: 'NunitoSans',
                                  ),
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () =>
                                      donationController.retryOperation(
                                    donationController.getDonations,
                                  ),
                                  child: const Text(
                                    'Retry',
                                    style: TextStyle(
                                      fontFamily: 'NunitoSans',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        // Show message if no donations
                        if (donationController.donations.isEmpty) {
                          return const Center(
                            child: Text(
                              'No donation history yet',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          );
                        }

                        // Show list of donations
                        return ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: donationController.donations.length,
                          itemBuilder: (context, index) {
                            // Get donation data for current item
                            final donation =
                                donationController.donations[index];

                            // Build donation card
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
                                  // Donation Type and Status
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Donation Type
                                      Expanded(
                                        child: Text(
                                          'Type: ${donation.type}',
                                          style: const TextStyle(
                                            fontFamily: 'NunitoSans',
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),

                                      // Status Badge
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color:
                                              donationController.getStatusColor(
                                                  donation.status ?? 'pending'),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Text(
                                          donationController.getStatusText(
                                              donation.status ?? 'pending'),
                                          style: const TextStyle(
                                            fontFamily: 'NunitoSans',
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 10),

                                  // Donation Details
                                  Text(
                                    'Quantity: ${donation.quantity}',
                                    style: const TextStyle(
                                      fontFamily: 'NunitoSans',
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  Text(
                                    'Shipping Method: ${donation.shippingMethod}',
                                    style: const TextStyle(
                                      fontFamily: 'NunitoSans',
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  Text(
                                    'Notes: ${donation.notes}',
                                    style: const TextStyle(
                                      fontFamily: 'NunitoSans',
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  Text(
                                    'Created at: ${donation.formattedDate}',
                                    style: const TextStyle(
                                      fontFamily: 'NunitoSans',
                                      fontWeight: FontWeight.w700,
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),

                                  // Cancel Button (only for pending donations)
                                  if (donation.status?.toLowerCase() ==
                                      'pending')
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Obx(() => TextButton.icon(
                                            // Disable button while processing
                                            onPressed: donationController
                                                    .isLoading.value
                                                ? null
                                                : () {
                                                    // Show confirmation dialog
                                                    Get.dialog(
                                                      AlertDialog(
                                                        title: const Text(
                                                          'Cancel Donation',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Montserrat',
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 20.0,
                                                          ),
                                                        ),
                                                        content: const Text(
                                                          'Are you sure you want to cancel this donation?',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'NunitoSans',
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 16.0,
                                                          ),
                                                        ),
                                                        actions: [
                                                          // No Button
                                                          TextButton(
                                                            onPressed: () =>
                                                                Get.back(),
                                                            child: const Text(
                                                              'No',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'NunitoSans',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                            ),
                                                          ),
                                                          // Yes Button
                                                          TextButton(
                                                            onPressed:
                                                                () async {
                                                              Get.back();
                                                              await donationController
                                                                  .cancelDonation(
                                                                      donation
                                                                          .id!);
                                                            },
                                                            style: TextButton
                                                                .styleFrom(
                                                              foregroundColor:
                                                                  Colors.red,
                                                            ),
                                                            child: const Text(
                                                              'Yes',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'NunitoSans',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                            // Show loading indicator or cancel icon
                                            icon: donationController
                                                    .isLoading.value
                                                ? const SizedBox(
                                                    width: 20,
                                                    height: 20,
                                                    child:
                                                        CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                                  Color>(
                                                              Colors.red),
                                                    ),
                                                  )
                                                : const Icon(
                                                    Icons.cancel_outlined,
                                                    color: Colors.red),
                                            label: const Text(
                                              'Cancel Donation',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontFamily: 'NunitoSans',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          )),
                                    ),
                                ],
                              ),
                            );
                          },
                        );
                      }),
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
