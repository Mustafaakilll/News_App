import 'package:flutter/material.dart';
import 'package:news_demo/data/http.dart';
import 'package:news_demo/model/news_article.dart';

class NewsState extends ChangeNotifier {
  HttpService _service = HttpService();

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<NewsArticle> _news;
  List<NewsArticle> get news => _news;

  Future<void> getAllRss() async {
    _isLoading = true;
    _news = await _service.getAllNews();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> getRssByCategory(String category) async {
    _isLoading = true;
    _news = await _service.getNewsByCategory(category);
    _isLoading = false;
    notifyListeners();
  }
}
