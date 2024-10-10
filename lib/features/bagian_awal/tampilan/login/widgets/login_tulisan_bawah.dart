import 'package:flutter/material.dart';

class LoginTulisanBawah extends StatelessWidget {
  const LoginTulisanBawah({
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
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                minimumSize: const Size(100, 40),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                ' Sign Up Here',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'NunitoSans',
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            minimumSize: const Size(100, 40),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text(
            'Forgot Password ?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'NunitoSans',
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
              letterSpacing: -0.5,
            ),
          ),
        ),
      ],
    );
  }
}
