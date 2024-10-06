import 'package:flutter/material.dart';

class CTextField extends StatefulWidget {
  final String label;
  final bool isPassword;

  const CTextField({
    Key? key,
    required this.label,
    this.isPassword = false,
  }) : super(key: key);

  @override
  _CTextFieldState createState() => _CTextFieldState();
}

class _CTextFieldState extends State<CTextField> {
  late final TextEditingController _controller;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Focus(
        onFocusChange: (hasFocus) {
          setState(() {
            _isFocused = hasFocus;
          });
        },
        child: TextFormField(
          controller: _controller,
          obscureText: widget.isPassword,
          decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: TextStyle(
              color: _isFocused || _controller.text.isNotEmpty
                  ? Colors.blue
                  : Colors.grey[700],
              fontFamily: 'NunitoSans',
              fontWeight: FontWeight.w500,
              fontSize: 14.0
            ),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black!),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 4),
          ),
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
