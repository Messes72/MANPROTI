import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:manpro/features/bagian_awal/tampilan/login/login.dart';
import 'package:manpro/navbar.dart';
import 'package:manpro/utils/constants/api_constants.dart';

class AuthenticationController extends GetxController {
  final isLoading = false.obs;
  final token = ''.obs;

  final box = GetStorage();

  Future register({
    required String nama_lengkap,
    required String username,
    required String email,
    required String kota_asal,
    required String no_telpon,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      var data = {
        "nama_lengkap": nama_lengkap,
        "username": username,
        "email": email,
        "kota_asal": kota_asal,
        "no_telpon": no_telpon,
        "password": password,
      };

      var response = await http.post(
        Uri.parse(url + 'register'),
        headers: {
          'Accept': 'application/json',
        },
        body: data,
      );

      if (response.statusCode == 201) {
        isLoading.value = false;
        token.value = json.decode(response.body)['token'];
        box.write('token', token.value);
        Get.offAll(() => const Login());
        Get.snackbar('Success', 'Akun berhasil dibuat',
            margin: const EdgeInsets.only(bottom: 10.0),
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white);
      } else {
        isLoading.value = false;
        Get.snackbar('Error', json.decode(response.body)['message'],
            margin: const EdgeInsets.only(bottom: 10.0),
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        print(json.decode(response.body));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future login({
    required String username,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      var data = {
        "username": username,
        "password": password,
      };

      var response = await http.post(
        Uri.parse(url + 'login'),
        headers: {
          'Accept': 'application/json',
        },
        body: data,
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        token.value = json.decode(response.body)['token'];
        box.write('token', token.value);
        Get.offAll(() => const Navbar());
      } else {
        isLoading.value = false;
        Get.snackbar('Error', json.decode(response.body)['message'],
            margin: const EdgeInsets.only(bottom: 10.0),
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        print(json.decode(response.body));
      }
    } catch (e) {
      print(e.toString());
    }
  }
}