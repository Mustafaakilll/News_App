import 'package:dio/dio.dart';

import '../model/news_article.dart';
import '../constant/api_constants.dart';

class HttpService {
  final _dio = Dio();

  Future<List<NewsArticle>> getAllNews() async {
    final _uri = Uri.https(ApiConstants.BASE_URL, ApiConstants.TOP_HEADLINE,
        {'country': 'tr', 'apiKey': ApiConstants.API_KEY});
    final response = await _dio.getUri(_uri);
    if (response.statusCode == 200) {
      final result = response.data;
      Iterable articles = result['articles'];
      return articles.map((article) => NewsArticle.fromJson(article)).toList();
    } else {
      throw Exception(ApiConstants.ERROR_MESSAGE);
    }
  }

  Future<List<NewsArticle>> getNewsByCategory(String category) async {
    final _uri = Uri.https(ApiConstants.BASE_URL, ApiConstants.TOP_HEADLINE, {
      'country': 'tr',
      'category': '$category',
      'apiKey': ApiConstants.API_KEY
    });

    final response = await _dio.getUri(_uri);

    if (response.statusCode == 200) {
      final result = response.data;
      Iterable articles = result['articles'];
      return articles.map((article) => NewsArticle.fromJson(article)).toList();
    } else {
      throw Exception(ApiConstants.ERROR_MESSAGE);
    }
  }
}
