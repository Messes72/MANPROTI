  import 'package:flutter/material.dart';
  import 'package:manpro/common/widgets/background_app.dart';

  import 'widgets/isi_profile_yayasan.dart';
  import 'widgets/tombol_back.dart';
  import 'widgets/tulisan_profile.dart';

  class ProfileYayasan extends StatelessWidget {
    const ProfileYayasan({super.key});

    @override
    Widget build(BuildContext context) {
      return const Scaffold(
        body: Stack(
          children: [
            BackgroundAPP(),
            SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tombol back
                      TombolBack(),

                      // Tulisan Profile yayasan
                      TulisanProfile(),
                      SizedBox(
                        height: 35.0,
                      ),

                      // Isi
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: IsiProfileYayasan(),
                        ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }
  }
