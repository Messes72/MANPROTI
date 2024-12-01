import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/donation_gallery.dart';
import '../../../utils/constants/api_constants.dart';

class DonationGalleryController {
  Future<List<DonationGallery>> getGalleryImages() async {
    try {
      final response = await http.get(Uri.parse('${url}donation-gallery'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == 'success' && data['data'] != null) {
          return (data['data'] as List)
              .map((json) => DonationGallery.fromJson(json))
              .toList();
        }
      }
      throw Exception('Failed to load gallery images');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
} 