import 'package:flutter/material.dart';

class TulisanBawah extends StatelessWidget {
  const TulisanBawah({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Don’t Have an Account ?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'NunitoSans',
                fontWeight: FontWeight.w500,
                letterSpacing: -0.5,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                ' Sign Up Here',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'NunitoSans',
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ],
        ),
        Container(
          child: TextButton(
            onPressed: () {},
            child: const Text(
              'Forgot Password ?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'NunitoSans',
                fontWeight: FontWeight.w500,
                letterSpacing: -0.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
