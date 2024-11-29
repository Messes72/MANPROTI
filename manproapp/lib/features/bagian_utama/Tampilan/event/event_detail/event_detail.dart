import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manpro/features/bagian_utama/controllers/eventController.dart';
import 'package:manpro/utils/constants/image_string.dart';
import 'package:manpro/common/widgets/background_app.dart';
import 'package:manpro/features/bagian_utama/Tampilan/event/event_detail/regis_event/regis_event.dart';

class EventDetail extends StatefulWidget {
  final int eventId;
  final String title;
  final String content;
  final String image;
  final String date;
  final String status;
  final String category;
  final List<String>? additionalImages;

  const EventDetail({
    Key? key,
    required this.eventId,
    required this.title,
    required this.content,
    required this.image,
    required this.date,
    required this.status,
    required this.category,
    this.additionalImages,
  }) : super(key: key);

  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  final _pageController = PageController();
  final _currentPage = 0.obs;
  final _images = <String>[].obs;
  final _isLoading = true.obs;
  late final EventController _eventController;

  @override
  void initState() {
    super.initState();
    _eventController = Get.find<EventController>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeImages();
      _loadEventDetail();
    });
  }

  void _initializeImages() {
    if (widget.image.isNotEmpty) {
      _images.add(widget.image);
    }
    if (widget.additionalImages != null &&
        widget.additionalImages!.isNotEmpty) {
      _images.addAll(widget.additionalImages!);
    }
  }

  Future<void> _loadEventDetail() async {
    try {
      await _eventController.refreshEventDetail(widget.eventId);
      final event = _eventController.events.firstWhereOrNull(
        (e) => e.id == widget.eventId,
      );

      if (event != null &&
          event.additionalImages != null &&
          event.additionalImages!.isNotEmpty) {
        _images.clear();
        if (event.image.isNotEmpty) {
          _images.add(event.image);
        }
        _images.addAll(event.additionalImages!);
      }
    } catch (e) {
      print('Error loading event detail: $e');
    } finally {
      _isLoading.value = false;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'upcoming':
        return Colors.green;
      case 'ongoing':
        return Colors.blue;
      case 'completed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _buildImageItem(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          _images[index],
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[300],
              child: const Center(
                child: Icon(
                  Icons.error_outline,
                  color: Colors.grey,
                  size: 50,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPageIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _images.length,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          width: _currentPage.value == index ? 12 : 8,
          height: _currentPage.value == index ? 12 : 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage.value == index
                ? Colors.black.withOpacity(0.9)
                : Colors.grey.withOpacity(0.7),
          ),
        ),
      ),
    );
  }

  Widget _buildImageGallery() {
    return Obx(() {
      if (_isLoading.value) {
        return const SizedBox(
          height: 200,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      if (_images.isEmpty) {
        return const SizedBox(
          height: 200,
          child: Center(
            child: Text('No images available'),
          ),
        );
      }

      return SizedBox(
        height: 200,
        child: Stack(
          alignment: Alignment.center,
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: _images.length,
              onPageChanged: (index) => _currentPage.value = index,
              itemBuilder: (context, index) => _buildImageItem(index),
            ),
            if (_images.length > 1)
              Positioned(
                bottom: 16,
                child: _buildPageIndicators(),
              ),
          ],
        ),
      );
    });
  }

  Widget _buildEventDetails() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date
          Text(
            widget.date,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontFamily: 'NunitoSans',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),

          // Title
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 24,
              fontFamily: 'NunitoSans',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),

          // Content
          Text(
            widget.content,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'NunitoSans',
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Add this method to check if registration is still open
  bool _canRegister() {
    try {
      // Parse date in format "d F Y" (e.g., "22 August 2024")
      final parts = widget.date.split(' ');
      if (parts.length != 3) return false;

      final day = int.parse(parts[0]);
      final months = {
        'January': 1,
        'February': 2,
        'March': 3,
        'April': 4,
        'May': 5,
        'June': 6,
        'July': 7,
        'August': 8,
        'September': 9,
        'October': 10,
        'November': 11,
        'December': 12
      };
      final month = months[parts[1]] ?? 1;
      final year = int.parse(parts[2]);

      final eventDate = DateTime(year, month, day);
      final now = DateTime.now();

      // Check if event is upcoming and date hasn't passed
      return widget.status.toLowerCase() == 'upcoming' &&
          now.isBefore(eventDate);
    } catch (e) {
      print('Error parsing date: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      onPressed: () => Get.back(),
                      icon: const ImageIcon(
                        AssetImage(YPKImages.icon_back_button),
                        size: 32.0,
                      ),
                    ),
                    const SizedBox(height: 25.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF7ABFB).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                widget.category,
                                style: const TextStyle(
                                  color: Color(0xFFF7ABFB),
                                  fontSize: 12,
                                  fontFamily: 'NunitoSans',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: _getStatusColor(widget.status)
                                    .withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                widget.status,
                                style: TextStyle(
                                  color: _getStatusColor(widget.status),
                                  fontSize: 12,
                                  fontFamily: 'NunitoSans',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildImageGallery(),
                    const SizedBox(height: 16),
                    _buildEventDetails(),
                    const SizedBox(height: 20),
                    // Register Button with updated condition
                    if (_canRegister())
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => Get.to(() => RegisEvent(
                                eventName: widget.title,
                                eventId: widget.eventId,
                              )),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF7ABFB),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(
                                color: Colors.black,
                                width: 1.5,
                              ),
                            ),
                          ),
                          child: const Text(
                            'Register Now',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
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
