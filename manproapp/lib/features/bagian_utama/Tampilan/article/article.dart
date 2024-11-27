import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manpro/common/widgets/background_app.dart';
import 'package:manpro/navbar.dart';
import 'package:manpro/utils/constants/image_string.dart';
import 'package:manpro/features/bagian_utama/Tampilan/article/article_detail/article_detail.dart';
import 'package:manpro/features/bagian_utama/controllers/articleController.dart';

class Article extends StatefulWidget {
  const Article({super.key});

  @override
  State<Article> createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
  final ArticleController articleController = Get.put(ArticleController());
  final TextEditingController _searchController = TextEditingController();

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
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        fontSize: 24.0,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search for an article...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 20),
                    Obx(() {
                      if (articleController.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final filteredArticles = articleController.articles
                          .where((article) => article.title
                              .toLowerCase()
                              .contains(_searchController.text.toLowerCase()))
                          .toList();

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredArticles.length,
                        itemBuilder: (context, index) {
                          final article = filteredArticles[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(16),
                                leading: Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: article.isAsset == 'true'
                                        ? Image.asset(
                                            article.image,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              print(
                                                  'Error loading asset image: $error');
                                              return Container(
                                                color: Colors.grey[300],
                                                child: const Icon(Icons.error),
                                              );
                                            },
                                          )
                                        : Image.network(
                                            article.image,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              print(
                                                  'Error loading network image: $error');
                                              return Container(
                                                color: Colors.grey[300],
                                                child: const Icon(Icons.error),
                                              );
                                            },
                                          ),
                                  ),
                                ),
                                title: Text(
                                  article.date,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontFamily: 'NunitoSans',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 8),
                                    Text(
                                      article.title,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontFamily: 'NunitoSans',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: const Icon(Icons.arrow_forward),
                                onTap: () {
                                  Get.to(() => const ArticleDetail(),
                                      arguments: article.toJson());
                                },
                              ),
                            ),
                          );
                        },
                      );
                    }),
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
