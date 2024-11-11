import 'dart:convert';
import 'package:http/http.dart' as http;

class API {
  Future<http.Response> postRequest({
    required String route,
    required Map<String, String> data,
  }) async {
    String url = 'http://10.0.2.2:8000/api/' + route;  // Gunakan base URL yang benar

    // Kirim request POST ke Laravel API
    return await http.post(
      Uri.parse(url),
      body: jsonEncode(data),
      headers: _header(),
    );
  }

  // Header untuk request
  Map<String, String> _header() => {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
}
