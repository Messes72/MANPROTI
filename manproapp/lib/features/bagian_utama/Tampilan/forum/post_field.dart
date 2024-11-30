import 'package:flutter/material.dart';

class PostField extends StatelessWidget {
  const PostField({super.key, required this.hintText, required this.controller, required bool obscureText});

  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 6,
            blurRadius: 7,
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          hintStyle: TextStyle(color: Colors.grey, fontSize: 18.0),
        ),
      ),
    );
  }
}
