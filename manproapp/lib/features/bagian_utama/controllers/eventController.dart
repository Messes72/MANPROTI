import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:manpro/features/bagian_utama/Tampilan/event_history/event_history.dart';
import 'package:manpro/utils/constants/api_constants.dart';
import 'package:manpro/features/bagian_utama/models/eventModel.dart';

class EventController extends GetxController {
  final isLoading = false.obs;
  final events = <Event>[].obs;
  final eventHistory = <EventRegistration>[].obs;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    getEvents();
    getEventHistory();
  }

  // Mengambil daftar event
  Future<void> getEvents() async {
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse('${url}events/list'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}'
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        events.value = data.map((json) => Event.fromJson(json)).toList();
      }
    } catch (e) {
      print('Error fetching events: ${e.toString()}');
      Get.snackbar(
        'Error',
        'Failed to load events',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Mendapatkan detail event
  Future<Event?> getEventDetail(int eventId) async {
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse('${url}events/$eventId'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}'
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        return Event.fromJson(data);
      }
      return null;
    } catch (e) {
      print('Error fetching event detail: ${e.toString()}');
      Get.snackbar(
        'Error',
        'Failed to load event detail',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  // Validasi email
  Future<bool> validateEmail(String email) async {
    try {
      final response = await http.post(
        Uri.parse('${url}validate-email'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}'
        },
        body: {
          'email': email,
        },
      );

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print('Error validating email: ${e.toString()}');
      return false;
    }
  }

  // Mendaftar event dengan validasi email
  Future<void> registerEvent({
    required int eventId,
    required String name,
    required String email,
  }) async {
    try {
      isLoading.value = true;
      
      // Validasi email terlebih dahulu
      final validateResponse = await http.post(
        Uri.parse('${url}validate-email'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}'
        },
        body: {
          'email': email,
        },
      );

      if (validateResponse.statusCode != 200) {
        throw json.decode(validateResponse.body)['message'] ?? 'Email validation failed';
      }

      final response = await http.post(
        Uri.parse('${url}events/register'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}'
        },
        body: {
          'event_id': eventId.toString(),
          'name': name,
          'email': email,
        },
      );

      if (response.statusCode == 201) {
        Get.snackbar(
          'Success',
          'Successfully registered for the event',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        await getEventHistory();
        Get.off(() => EventHistory());
      } else {
        final message = json.decode(response.body)['message'] ?? 'Registration failed';
        throw message;
      }
    } catch (e) {
      print('Error registering for event: ${e.toString()}');
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

  // Mengambil riwayat event
  Future<void> getEventHistory() async {
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse('${url}event/history'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}'
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        eventHistory.value =
            data.map((json) => EventRegistration.fromJson(json)).toList();
      }
    } catch (e) {
      print('Error fetching event history: ${e.toString()}');
      Get.snackbar(
        'Error',
        'Failed to load event history',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Method untuk refresh data
  Future<void> refreshData() async {
    await getEvents();
    await getEventHistory();
  }
}
