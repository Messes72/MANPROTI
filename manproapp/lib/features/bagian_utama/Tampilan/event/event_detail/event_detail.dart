import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manpro/common/widgets/background_app.dart';
import 'package:manpro/features/bagian_utama/Tampilan/event/event.dart';
import 'package:manpro/features/bagian_utama/Tampilan/event/event_detail/regis_event/regis_event.dart';
import 'package:manpro/utils/constants/image_string.dart';

class EventDetail extends StatelessWidget {
  final String title;
  final String content;
  final String image;
  final String date;
  final List<String>? additionalImages;

  const EventDetail({
    super.key,
    required this.title,
    required this.content,
    required this.image,
    required this.date,
    this.additionalImages,
  });

  void _showImageOverlay(
      BuildContext context, List<String> images, int initialIndex) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: Stack(
          children: [
            PageView.builder(
              itemCount: images.length,
              controller: PageController(initialPage: initialIndex),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.black.withOpacity(0.5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 40),
                      child: InteractiveViewer(
                        minScale: 0.5,
                        maxScale: 3.0,
                        child: Image.asset(
                          images[index],
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            Positioned(
              top: 40,
              right: 20,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 30),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> eventImages = [
      image,
      ...?additionalImages,
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
                      onPressed: () => Get.to(() => const Event()),
                      icon: const ImageIcon(
                        AssetImage(YPKImages.icon_back_button),
                        size: 32.0,
                      ),
                    ),
                    const SizedBox(height: 25.0),
                    const Text(
                      'Events',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        fontSize: 24.0,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 200,
                      child: Stack(
                        children: [
                          PageView.builder(
                            itemCount: eventImages.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () => _showImageOverlay(
                                    context, eventImages, index),
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    image: DecorationImage(
                                      image: AssetImage(eventImages[index]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          Positioned(
                            bottom: 10,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                eventImages.length,
                                (index) => Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            date,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontFamily: 'NunitoSans',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 24,
                              fontFamily: 'NunitoSans',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            content,
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'NunitoSans',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: () => Get.to(() => RegisEvent(eventName: title)),
                        child: const Text('Daftar Event'),
                      ),
                    ),
                    const SizedBox(height: 30.0),
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
