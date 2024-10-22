import 'dart:convert';
import 'package:http/http.dart' as http;

// Model Profile
class UserProfile {
  final String firstName;
  final String lastName;
  final String address;
  final String email;
  final String phone;
  final String dob;
  final String? profilePicture;

  UserProfile({
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.email,
    required this.phone,
    required this.dob,
    this.profilePicture,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      firstName: json['first_name'],
      lastName: json['last_name'],
      address: json['address'],
      email: json['email'],
      phone: json['phone'],
      dob: json['dob'],
      profilePicture: json['profile_picture'],
    );
  }
}

// Fungsi untuk mengambil profile dari backend Laravel
Future<UserProfile> fetchProfile(int id) async {
  final response = await http.get(Uri.parse('http://localhost:8000/api/profiles/$id'));

  if (response.statusCode == 200) {
    return UserProfile.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load profile');
  }
}
