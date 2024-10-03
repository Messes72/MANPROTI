import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25.0, 7.0, 12.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 13.0),
                    width: 120,
                    height: 120,
                    child: Transform.scale(
                      scale: 1.8,
                      child: Image.asset(
                        'assets/logo yayasan.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    child: IconButton(
                      onPressed: () {},
                      icon: Image.asset('assets/garis tiga.jpg'),
                    ),
                  ),
                ],
              ),
              const Text(
                'Halo, Jehezkiel Louis !',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                  fontSize: 24.0,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 27.0),
              const Text(
                'Event Information',
                style: TextStyle(
                  fontFamily: 'NunitoSans',
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
