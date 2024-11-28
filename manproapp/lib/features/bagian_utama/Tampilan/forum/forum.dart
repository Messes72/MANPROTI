import 'package:flutter/material.dart';
import 'package:manpro/common/widgets/background_app.dart';
import 'package:manpro/navbar.dart';
import 'package:manpro/utils/constants/image_string.dart';
import 'package:get/get.dart';
import 'package:manpro/features/bagian_utama/Tampilan/forum/post_field.dart';
import 'package:manpro/features/bagian_utama/Tampilan/forum/post_data.dart';


class Forum extends StatelessWidget {
  const Forum({super.key});

  @override
  Widget build(BuildContext context) {

    final TextEditingController _postController = TextEditingController();
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundAPP(),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () => Get.to(() => const Navbar()),
                      icon: const ImageIcon(
                        AssetImage(YPKImages.icon_back_button),
                        size: 32.0,
                      ),
                    ),
                    const SizedBox(height: 25.0),
                    const Text(
                      'Forum Chat',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        fontSize: 24.0,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Selamat datang di forum kami! Silahkan berbagi pendapat Anda.',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PostField(
                              hintText: 'Tulis pesan Anda...',
                          controller: _postController,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.withOpacity(0.5),
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Kirim',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                              fontSize: 16.0,
                            ),
                          ),
                          ),
                          const SizedBox(height: 30,),
                          Text('Forum Terbaru',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                            fontSize: 20.0,
                          ),
                          ),
                          const SizedBox(height: 20,),
                          PostData(),
                          const SizedBox(height: 20,),
                          PostData(),
                          const SizedBox(height: 20,),
                          PostData(),
                          ],
                        ),
                      ),
                    ),
                  ],
              ),
            ),
          ),
          ),
        ],
      ),
    );
  }
}
