import 'package:dio/dio.dart';

import '../model/news_article.dart';

class HttpService {
  var dio = Dio();

  Future<List<NewsArticle>> getAllNews() async {
    final _url =
        'http://newsapi.org/v2/top-headlines?country=tr&apiKey=97604a4cfe784fc7a9ae242ac28b2c87';
    final response = await dio.get(_url);
    if (response.statusCode == 200) {
      final result = response.data;
      Iterable articles = result['articles'];
      return articles.map((article) => NewsArticle.fromJson(article)).toList();
    } else {
      throw Exception('Failled to get top news');
    }
  }

  Future<List<NewsArticle>> getNewsByCategory(String category) async {
    final response = await dio.get(
        'http://newsapi.org/v2/top-headlines?country=tr&category=$category&apiKey=97604a4cfe784fc7a9ae242ac28b2c87');

    if (response.statusCode == 200) {
      final result = response.data;
      Iterable articles = result['articles'];
      return articles.map((article) => NewsArticle.fromJson(article)).toList();
    } else {
      throw Exception('Failled to get top news');
    }
  }
}
