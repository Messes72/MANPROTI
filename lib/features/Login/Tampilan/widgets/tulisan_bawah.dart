import 'package:flutter/material.dart';

class TulisanBawah extends StatelessWidget {
  const TulisanBawah({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'Don’t Have an Account ? Sign Up Here',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'NunitoSans',
            fontWeight: FontWeight.w500,
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(height: 7.0),
        Text(
          'Forgot Password ?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'NunitoSans',
            fontWeight: FontWeight.w500,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }
}
