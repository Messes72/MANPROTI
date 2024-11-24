import 'package:flutter/material.dart';
  
class IsiFP extends StatelessWidget {
  const IsiFP({
    super.key,
    required this.labelText,
    required this.controller,
  });

  final String labelText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
            fontFamily: 'NunitoSans',
            fontWeight: FontWeight.w500,
            fontSize: 14.0),
      ),
    );
  }
}
