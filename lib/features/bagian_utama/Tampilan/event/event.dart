import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manpro/common/widgets/background_app.dart';
import 'package:manpro/features/bagian_utama/Tampilan/event/event_detail/event_detail.dart';
import 'package:manpro/navbar.dart';
import 'package:manpro/utils/constants/image_string.dart';

class Event extends StatelessWidget {
  const Event({super.key});

  @override
  Widget build(BuildContext context) {
    // List of events, each with a unique image and title
    final List<Map<String, String>> events = [
      {
        'image': YPKImages.gbr_event1,
        'title': 'Acara Bhaktiku Negri',
        'date': '17 Maret 2024',
        'content':
            "Webinar yang fokus membahas dan menyuarakan isu seputar Anak Berkebutuhan Khusus dilihat dari aspek parenting, keterampilan, pendidikan, komunikasi, kewirausahaan, dan lainnya. Kami mengundang para praktisi, artis, hingga pengambil kebijakan sebagai pemateri atau narasumber webinar, sedangkan ABK atau orang tuanya sebagai host atau moderator webinar untuk melatih kepercayaan diri dan keterampilan berkomunikasi Detail webinar kelas #Akademiability dapat dilihat di Channel Youtube Peduli Kasih ABK"
      },
      {
        'image': YPKImages.gbr_event2,
        'title': 'Acara Bhaktiku Negri 2',
        'date': '18 Maret 2024',
        'content': 'Ini adalah isi lengkap artikel Acara Bhaktiku Negri 2...'
      },
      {
        'image': YPKImages.gbr_event3,
        'title': 'Acara Bhaktiku Negri 3',
        'date': '19 Maret 2024',
        'content': 'Ini adalah isi lengkap artikel Acara Bhaktiku Negri 3...'
      },
      {
        'image': YPKImages.gbr_event3,
        'title': 'Acara Bhaktiku Negri 4',
        'date': '20 Maret 2024',
        'content': 'Ini adalah isi lengkap artikel Acara Bhaktiku Negri 4...'
      },
      // Additional events can be added here
    ];

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
                    const Center(
                      child: Text(
                        'Events',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                          fontSize: 24.0,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Dynamically generate event cards
                    ...events.map((event) => Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EventDetail(
                                    title: event['title']!,
                                    content: event['content']!,
                                    image: event['image']!,
                                    date: event['date']!, // Added missing date parameter
                                  ),
                                ),
                              );
                            },
                            child: buildArticleCard(
                              event['image']!,
                              event['title']!,
                              event['date']!,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildArticleCard(String imagePath, String title, String date) {
    return Align(
      alignment: const FractionalOffset(0.5, 0.2),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(
          children: [
            Image.asset(
              imagePath,
              width: 350,
              height: 200,
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                color: Colors.black.withOpacity(0.5),
                child: Column(
                  children: [
                    Text(
                      date,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
