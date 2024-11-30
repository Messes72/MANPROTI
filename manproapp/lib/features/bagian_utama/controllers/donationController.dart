import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:manpro/features/bagian_utama/models/donationModel.dart';
import 'package:manpro/features/bagian_utama/models/donationTypeModel.dart';
import 'package:manpro/features/bagian_utama/models/shippingMethodModel.dart';
import 'package:manpro/utils/constants/api_constants.dart';

class DonationController extends GetxController {
  final isLoading = false.obs;
  final donations = <DonationModel>[].obs;
  final donationTypes = <DonationType>[].obs;
  final shippingMethods = <ShippingMethod>[].obs;
  final box = GetStorage();
  final hasError = false.obs;
  final errorMessage = ''.obs;

  Future<void> retryOperation(Future<void> Function() operation) async {
    hasError.value = false;
    errorMessage.value = '';
    await operation();
  }

  void handleError(dynamic error) {
    hasError.value = true;
    errorMessage.value = error.toString();
    Get.snackbar(
      'Error',
      error.toString(),
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 5),
      mainButton: TextButton(
        onPressed: () => retryOperation(getDonations),
        child: const Text('Retry', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  @override
  void onInit() {
    super.onInit();
    getDonations();
    getDonationTypes();
    getShippingMethods();
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'accepted':
        return Colors.blue;
      case 'success':
        return Colors.green;
      case 'failed':
        return Colors.red.shade900;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String getStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'Menunggu Konfirmasi';
      case 'accepted':
        return 'Diterima';
      case 'success':
        return 'Berhasil';
      case 'failed':
        return 'Ditolak';
      case 'cancelled':
        return 'Dibatalkan';
      default:
        return status.toUpperCase();
    }
  }

  Future<void> getDonations() async {
    try {
      isLoading.value = true;
      final token = box.read('token');

      final response = await http.get(
        Uri.parse('${url}donations/history'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception(
              'Connection timeout. Please check your internet connection.');
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        donations.value =
            data.map((json) => DonationModel.fromJson(json)).toList();
        hasError.value = false;
        errorMessage.value = '';
      } else {
        throw Exception('Failed to load donations. Please try again later.');
      }
    } catch (e) {
      print('Error getting donations: $e');
      handleError(e);
    } finally {
      isLoading.value = false;
    }
  }

  bool validateDonation(DonationModel donation) {
    if (donation.type.isEmpty ||
        donation.quantity.isEmpty ||
        donation.shippingMethod.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all required fields',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }
    return true;
  }

  Future<void> createDonation(DonationModel donation) async {
    if (!validateDonation(donation)) return;

    try {
      isLoading.value = true;
      final token = box.read('token');

      final response = await http.post(
        Uri.parse('${url}donations'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: donation.toJson(),
      );

      if (response.statusCode == 201) {
        getDonations();
        Get.back();
        Get.snackbar(
          'Success',
          'Donation created successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        throw json.decode(response.body)['message'];
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> cancelDonation(int id) async {
    try {
      isLoading.value = true;
      final token = box.read('token');

      final response = await http.patch(
        Uri.parse('${url}donations/$id/cancel'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception(
              'Connection timeout. Please check your internet connection.');
        },
      );

      if (response.statusCode == 200) {
        await getDonations();
        Get.snackbar(
          'Success',
          'Donation cancelled successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        throw json.decode(response.body)['message'];
      }
    } catch (e) {
      handleError(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getDonationTypes() async {
    try {
      final response = await http.get(
        Uri.parse('${url}donation-types'),
        headers: {'Accept': 'application/json'},
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        donationTypes.value =
            data.map((json) => DonationType.fromJson(json)).toList();
      }
    } catch (e) {
      print('Error getting donation types: $e');
    }
  }

  Future<void> getShippingMethods() async {
    try {
      final response = await http.get(
        Uri.parse('${url}shipping-methods'),
        headers: {'Accept': 'application/json'},
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        shippingMethods.value =
            data.map((json) => ShippingMethod.fromJson(json)).toList();
      }
    } catch (e) {
      print('Error getting shipping methods: $e');
    }
  }
}
