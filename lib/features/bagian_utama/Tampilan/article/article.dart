import 'package:flutter/material.dart';
import 'package:manpro/features/bagian_utama/Tampilan/article_detail/article_detail.dart';
import 'package:manpro/utils/constants/image_string.dart';

class Article extends StatelessWidget {
  const Article({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 45),
            Padding(
              padding: const EdgeInsets.symmetric(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.black,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const Text(
                    'Articles',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.list),
                    color: Colors.black,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Menu clicked')),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // GestureDetector untuk card pertama
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ArticleDetail(
                      title: 'Acara Bhaktiku Negri',
                      content: "Contrary to popular belief, Lorem Ipsum is not simply random text. "
                          "It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. "
                          "Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more "
                          "obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in "
                          "classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of (The Extremes of Good and Evil) by "
                          "Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. "
                          "The first line of Lorem Ipsum, comes from a line in section 1.10.32.",
                    ),
                  ),
                );
              },
              child: buildArticleCard(
                YPKImages.gbr_event1,
                'Acara Bhaktiku Negri',
              ),
            ),
            const SizedBox(height: 20),

            // GestureDetector untuk card kedua
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ArticleDetail(
                      title: 'Acara Bhaktiku Negri 2',
                      content: 'Ini adalah isi lengkap artikel Acara Bhaktiku Negri 2...',
                    ),
                  ),
                );
              },
              child: buildArticleCard(
                YPKImages.gbr_event1,
                'Acara Bhaktiku Negri 2',
              ),
            ),
            const SizedBox(height: 20),

            // GestureDetector untuk card ketiga
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ArticleDetail(
                      title: 'Acara Bhaktiku Negri 3',
                      content: 'Ini adalah isi lengkap artikel Acara Bhaktiku Negri 3...',
                    ),
                  ),
                );
              },
              child: buildArticleCard(
                YPKImages.gbr_event1,
                'Acara Bhaktiku Negri 3',
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function untuk membangun card
  Widget buildArticleCard(String imagePath, String title) {
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
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}