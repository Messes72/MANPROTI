import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manpro/common/widgets/background_app.dart';
import 'package:manpro/navbar.dart';
import 'package:manpro/utils/constants/image_string.dart';
import 'package:manpro/features/bagian_utama/Tampilan/article/article_detail/article_detail.dart';

class Article extends StatefulWidget {
  const Article({super.key});

  @override
  State<Article> createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
  // Controller untuk search
  final TextEditingController _searchController = TextEditingController();

  // List untuk menyimpan semua artikel
  final List<Map<String, String>> _allArticles = [
    {
      'title': 'Acara Bhaktiku Negri',
      'date': '17 Maret 2024',
      'image': YPKImages.gbr_event1,
      'isAsset': 'true',
      'content':
          'Webinar yang fokus membahas dan menyuarakan isu seputar Anak Berkebutuhan Khusus...'
    },
    {
      'title': 'Seminar Pendidikan Inklusif',
      'date': '18 Maret 2024',
      'image': YPKImages.gbr_event2,
      'isAsset': 'true',
      'content':
          'Seminar membahas pentingnya pendidikan inklusif untuk anak berkebutuhan khusus...'
    },
    {
      'title': 'Workshop Keterampilan ABK',
      'date': '19 Maret 2024',
      'image': YPKImages.gbr_event3,
      'isAsset': 'true',
      'content':
          'Workshop pengembangan keterampilan untuk anak berkebutuhan khusus...'
    }
  ];

  // List untuk artikel yang ditampilkan (hasil filter)
  List<Map<String, String>> _filteredArticles = [];

  @override
  void initState() {
    super.initState();
    _filteredArticles = _allArticles;
  }

  // Fungsi untuk filter artikel berdasarkan search
  void _filterArticles(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredArticles = _allArticles;
      } else {
        _filteredArticles = _allArticles
            .where((article) =>
                article['title']!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
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
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
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
                      'Articles',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        fontSize: 24.0,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Search bar
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        controller: _searchController,
                        onChanged: _filterArticles,
                        decoration: InputDecoration(
                          hintText: "Search for an article...",
                          hintStyle: const TextStyle(
                            fontFamily: 'NunitoSans',
                            fontWeight: FontWeight.w700,
                          ),
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                    // List of articles
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _filteredArticles.length,
                      itemBuilder: (context, index) {
                        final article = _filteredArticles[index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => const ArticleDetail(),
                                arguments: article);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  // Article image
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        bottomLeft: Radius.circular(15),
                                      ),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: article['isAsset'] == 'true'
                                            ? AssetImage(article['image']!)
                                                as ImageProvider
                                            : NetworkImage(article['image']!),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            article['date']!,
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontFamily: 'NunitoSans',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            article['title']!,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'NunitoSans',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.arrow_forward),
                                    onPressed: () {
                                      Get.to(() => const ArticleDetail(),
                                          arguments: article);
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
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
