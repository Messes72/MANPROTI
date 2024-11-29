import 'package:manpro/features/bagian_utama/models/eventCategoryModel.dart';
import 'dart:convert';

class Event {
  final int id;
  final String title;
  final String content;
  final String image;
  final String date;
  final String createdAt;
  final int? registrationsCount;
  final List<String>? additionalImages;
  final EventCategory? category;
  final String status;

  Event({
    required this.id,
    required this.title,
    required this.content,
    required this.image,
    required this.date,
    required this.createdAt,
    this.registrationsCount,
    this.additionalImages,
    this.category,
    required this.status,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    print('Parsing event JSON for ID: ${json['id']}');
    print('Raw additional_images: ${json['additional_images']}');

    List<String>? parseAdditionalImages(dynamic value) {
      if (value == null) return null;

      try {
        if (value is String) {
          // Handle JSON string
          final decoded = jsonDecode(value);
          if (decoded is List) {
            return List<String>.from(decoded);
          }
          return null;
        } else if (value is List) {
          // Handle array directly
          return List<String>.from(value);
        } else if (value is String && value.startsWith('[')) {
          // Handle JSON array string
          final decoded = jsonDecode(value);
          return List<String>.from(decoded);
        }
      } catch (e) {
        print('Error parsing additional_images: $e');
        print('Value type: ${value.runtimeType}');
        print('Value: $value');
      }
      return null;
    }

    final additionalImages = parseAdditionalImages(json['additional_images']);
    print('Parsed additional_images: $additionalImages');

    return Event(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      image: json['image'],
      date: json['date'],
      createdAt: json['created_at'],
      registrationsCount: json['registrations_count'],
      additionalImages: additionalImages,
      category: json['category'] != null
          ? EventCategory.fromJson(json['category'])
          : null,
      status: json['status'] ?? 'upcoming',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'image': image,
      'date': date,
      'created_at': createdAt,
      'registrations_count': registrationsCount,
      'additional_images': additionalImages,
      'category': category?.toJson(),
      'status': status,
    };
  }

  bool get isCompleted => status == 'completed';
  bool get isOngoing => status == 'ongoing';
  bool get isUpcoming => status == 'upcoming';

  bool get canRegister {
    try {
      // Parse date in format "d F Y" (e.g., "22 August 2024")
      final parts = date.split(' ');
      if (parts.length != 3) return false;
      
      final day = int.parse(parts[0]);
      final month = _parseMonth(parts[1]);
      final year = int.parse(parts[2]);
      
      final eventDate = DateTime(year, month, day);
      final now = DateTime.now();
      return now.isBefore(eventDate) && status == 'upcoming';
    } catch (e) {
      print('Error parsing date: $e');
      return false;
    }
  }

  static int _parseMonth(String month) {
    const months = {
      'January': 1, 'February': 2, 'March': 3, 'April': 4,
      'May': 5, 'June': 6, 'July': 7, 'August': 8,
      'September': 9, 'October': 10, 'November': 11, 'December': 12
    };
    return months[month] ?? 1;  // Default to January if month not found
  }
}

class EventRegistration {
  final int id;
  final int eventId;
  final int userId;
  final String name;
  final String email;
  final Event? event;

  EventRegistration({
    required this.id,
    required this.eventId,
    required this.userId,
    required this.name,
    required this.email,
    this.event,
  });

  factory EventRegistration.fromJson(Map<String, dynamic> json) {
    return EventRegistration(
      id: json['id'],
      eventId: json['event_id'],
      userId: json['user_id'],
      name: json['name'],
      email: json['email'],
      event: json['event'] != null ? Event.fromJson(json['event']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'event_id': eventId,
      'user_id': userId,
      'name': name,
      'email': email,
      'event': event?.toJson(),
    };
  }
}
