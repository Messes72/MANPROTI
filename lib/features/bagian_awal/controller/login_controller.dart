import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;
}