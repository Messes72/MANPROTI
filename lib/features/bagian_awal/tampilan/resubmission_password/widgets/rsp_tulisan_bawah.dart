import 'package:flutter/material.dart';

class RspTulisanBawah extends StatelessWidget {
  const RspTulisanBawah({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30.0),
      child: Row(
        children: [
          ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[200],
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              minimumSize: const Size(120, 40),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            label: const Text(
              'Cancel',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'NunitoSans',
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
                letterSpacing: -0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
