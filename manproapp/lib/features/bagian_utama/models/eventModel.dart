class Event {
  final int id;
  final String title;
  final String content;
  final String image;
  final String date;
  final String createdAt;
  final int? registrationsCount;
  final List<String>? additionalImages;

  Event({
    required this.id,
    required this.title,
    required this.content,
    required this.image,
    required this.date,
    required this.createdAt,
    this.registrationsCount,
    this.additionalImages,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      image: json['image'],
      date: json['date'],
      createdAt: json['created_at'],
      registrationsCount: json['registrations_count'],
      additionalImages: json['additional_images'] != null
          ? List<String>.from(json['additional_images'])
          : null,
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
    };
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
