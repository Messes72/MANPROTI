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
  final box = GetStorage();
  final donationTypes = <DonationType>[].obs;
  final shippingMethods = <ShippingMethod>[].obs;

  @override
  void onInit() {
    super.onInit();
    getDonationHistory();
    getDonationTypes();
    getShippingMethods();
  }

  Future<void> createDonation({
    required String type,
    required String quantity,
    required String shippingMethod,
    required String notes,
  }) async {
    try {
      isLoading.value = true;
      final token = box.read('token');

      var data = {
        'type': type,
        'quantity': quantity,
        'shipping_method': shippingMethod,
        'notes': notes,
      };

      var response = await http.post(
        Uri.parse('${url}donations'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: data,
      );

      if (response.statusCode == 201) {
        isLoading.value = false;
        Get.snackbar(
          'Success',
          'Donation created successfully',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        getDonationHistory(); // Refresh the history
      } else {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Something went wrong',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print(e.toString());
    }
  }

  Future<void> getDonationHistory() async {
    try {
      isLoading.value = true;
      final token = box.read('token');

      var response = await http.get(
        Uri.parse('${url}donations/history'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        var donationsList = jsonResponse['data'] as List;
        donations.value = donationsList
            .map((donation) => DonationModel.fromJson(donation))
            .toList();
        isLoading.value = false;
      } else {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          'Failed to load donation history',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  Future<void> updateDonationStatus(int donationId, String status) async {
    try {
      isLoading.value = true;
      final token = box.read('token');

      var response = await http.patch(
        Uri.parse('${url}donations/$donationId/status'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
          'status': status,
        },
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        Get.snackbar(
          'Success',
          'Status updated successfully',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        getDonationHistory(); // Refresh the list
      } else {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  Future<void> getDonationTypes() async {
    try {
      var response = await http.get(
        Uri.parse('${url}donation-types'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body)['data'] as List;
        donationTypes.value = data
            .map((type) => DonationType(
                  id: type['id'],
                  name: type['name'],
                ))
            .toList();
      }
    } catch (e) {
      print('Error getting donation types: $e');
    }
  }

  Future<void> getShippingMethods() async {
    try {
      var response = await http.get(
        Uri.parse('${url}shipping-methods'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body)['data'] as List;
        shippingMethods.value = data
            .map((method) => ShippingMethod(
                  id: method['id'],
                  name: method['name'],
                ))
            .toList();
      }
    } catch (e) {
      print('Error getting shipping methods: $e');
    }
  }

  Future<void> cancelDonation(int donationId) async {
    try {
      isLoading.value = true;
      final token = box.read('token');

      var response = await http.patch(
        Uri.parse('${url}donations/$donationId/cancel'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          'Donation cancelled successfully',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        getDonationHistory(); // Refresh the list
      } else {
        var errorMessage = json.decode(response.body)['message'];
        Get.snackbar(
          'Error',
          errorMessage,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('Error cancelling donation: $e');
      Get.snackbar(
        'Error',
        'Failed to cancel donation',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
