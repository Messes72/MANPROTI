import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:manpro/utils/constants/api_constants.dart';
import 'package:manpro/features/bagian_utama/models/eventModel.dart';
import 'package:manpro/features/bagian_utama/Tampilan/event_history/event_history.dart';

class EventController extends GetxController {
  // =========== VARIABLES ===========
  // Singleton instance
  static EventController get instance => Get.find<EventController>();
  
  // State variables
  final isLoading = false.obs;
  final events = <Event>[].obs;
  final eventHistory = <EventRegistration>[].obs;
  final selectedCategory = RxString('');
  
  // Storage
  final box = GetStorage();

  // =========== LIFECYCLE METHODS ===========
  @override
  void onInit() {
    super.onInit();
    getEvents();
    getEventHistory();
  }

  // =========== EVENT LIST METHODS ===========
  /// Fetches and sorts the list of events
  Future<void> getEvents({String? category}) async {
    try {
      if (isLoading.value) return;
      isLoading.value = true;
      
      // Build API endpoint
      String endpoint = '${url}events/list';
      if (category != null && category.isNotEmpty) {
        endpoint += '?category=$category';
      }

      // Make API call
      final response = await http.get(
        Uri.parse(endpoint),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}'
        },
      );

      if (response.statusCode == 200) {
        // Parse response
        final responseJson = json.decode(response.body);
        final List<dynamic> data = responseJson['data'];
        
        // Convert JSON to Event objects
        final parsedEvents = data.map((json) => Event.fromJson(json)).toList();
        
        // Sort events by date (newest first)
        _sortEvents(parsedEvents);

        // Update events list
        events.clear();
        events.addAll(parsedEvents);
      }
    } catch (e) {
      print('Error fetching events: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Fetches events for the home screen carousel
  Future<void> getActiveEventImages() async {
    try {
      if (isLoading.value) return;
      isLoading.value = true;
      
      final response = await http.get(
        Uri.parse('${url}events/list'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}'
        },
      );

      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        final List<dynamic> data = responseJson['data'];
        
        // Parse and sort events
        final parsedEvents = data.map((json) => Event.fromJson(json)).toList();
        _sortEvents(parsedEvents);

        // Update events list
        events.clear();
        events.addAll(parsedEvents);
      }
    } catch (e) {
      print('Error fetching event images: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // =========== EVENT DETAIL METHODS ===========
  /// Fetches detailed information for a specific event
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
      print('Error fetching event detail: $e');
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  /// Refreshes event detail and updates the events list
  Future<void> refreshEventDetail(int eventId) async {
    final event = await getEventDetail(eventId);
    if (event != null) {
      final index = events.indexWhere((e) => e.id == eventId);
      if (index != -1) {
        events[index] = event;
      }
    }
  }

  // =========== EVENT REGISTRATION METHODS ===========
  /// Validates user email for event registration
  Future<bool> validateEmail(String email) async {
    try {
      final response = await http.post(
        Uri.parse('${url}validate-email'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}'
        },
        body: {'email': email},
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error validating email: $e');
      return false;
    }
  }

  /// Registers user for an event
  Future<void> registerEvent({
    required int eventId,
    required String name,
    required String email,
  }) async {
    try {
      isLoading.value = true;

      // Check if event exists and is open for registration
      final event = await getEventDetail(eventId);
      if (event == null) {
        throw 'Event not found';
      }
      if (!event.canRegister) {
        throw 'Registration is closed for this event';
      }

      // Validate email
      final isEmailValid = await validateEmail(email);
      if (!isEmailValid) {
        throw 'Email validation failed';
      }

      // Register for event
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
      }
    } catch (e) {
      print('Error registering for event: $e');
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

  // =========== EVENT HISTORY METHODS ===========
  /// Fetches user's event registration history
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
        eventHistory.value = data.map((json) => EventRegistration.fromJson(json)).toList();
      }
    } catch (e) {
      print('Error fetching event history: $e');
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

  /// Cancels an event registration
  Future<void> cancelEventRegistration(int registrationId) async {
    try {
      isLoading.value = true;
      
      final response = await http.delete(
        Uri.parse('${url}events/registration/$registrationId'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}'
        },
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          'Event registration cancelled successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        await getEventHistory();
      } else {
        Get.snackbar(
          'Error',
          'Failed to cancel registration',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('Error cancelling registration: $e');
      Get.snackbar(
        'Error',
        'Something went wrong',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // =========== HELPER METHODS ===========
  /// Sorts events by date (newest first)
  void _sortEvents(List<Event> eventList) {
    eventList.sort((a, b) {
      try {
        final partsA = a.date.split(' ');
        final partsB = b.date.split(' ');
        
        if (partsA.length != 3 || partsB.length != 3) return 0;
        
        final yearA = int.parse(partsA[2]);
        final yearB = int.parse(partsB[2]);
        if (yearA != yearB) return yearB.compareTo(yearA);
        
        final monthA = _parseMonth(partsA[1]);
        final monthB = _parseMonth(partsB[1]);
        if (monthA != monthB) return monthB.compareTo(monthA);
        
        final dayA = int.parse(partsA[0]);
        final dayB = int.parse(partsB[0]);
        return dayB.compareTo(dayA);
      } catch (e) {
        print('Error sorting dates: $e');
        return 0;
      }
    });
  }

  /// Converts month name to number (e.g., "January" -> 1)
  int _parseMonth(String month) {
    const months = {
      'January': 1, 'February': 2, 'March': 3, 'April': 4,
      'May': 5, 'June': 6, 'July': 7, 'August': 8,
      'September': 9, 'October': 10, 'November': 11, 'December': 12
    };
    return months[month] ?? 1;  // Default to January if month not found
  }

  // =========== CATEGORY METHODS ===========
  /// Filters events by category
  Future<void> filterByCategory(String category) async {
    selectedCategory.value = category;
    await getEvents(category: category);
  }

  /// Resets category filter
  void resetFilter() {
    selectedCategory.value = '';
    getEvents();
  }
}
