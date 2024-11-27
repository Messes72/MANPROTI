import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:manpro/features/bagian_utama/models/articleModel.dart';
import 'package:manpro/utils/constants/api_constants.dart';

class ArticleController extends GetxController {
  final isLoading = false.obs;
  final articles = <Article>[].obs;
  final currentArticle = Rxn<Article>();

  @override
  void onInit() {
    super.onInit();
    fetchArticles();
  }

  Future<void> fetchArticles() async {
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse('${url}articles/list'),
        headers: {
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print('Response body: ${response.body}');
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> articlesJson = responseData['data'];
        articles.value =
            articlesJson.map((json) => Article.fromJson(json)).toList();

        articles.forEach((article) {
          print('Article image path: ${article.image}');
        });
      } else {
        print('Failed to load articles: ${response.body}');
      }
    } catch (e) {
      print('Error fetching articles: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchArticleDetails(int articleId) async {
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse('${url}articles/$articleId'),
        headers: {
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final articleJson = json.decode(response.body)['data'];
        currentArticle.value = Article.fromJson(articleJson);
      } else {
        print('Failed to load article details: ${response.body}');
      }
    } catch (e) {
      print('Error fetching article details: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
