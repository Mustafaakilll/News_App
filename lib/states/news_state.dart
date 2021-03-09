import 'package:flutter/material.dart';
import 'package:turkish/turkish.dart';

import '../data/http.dart';
import '../model/news_article.dart';

class NewsState extends ChangeNotifier {
  final HttpService _service = HttpService();

  final List<NewsArticle> _filteredNews = [];
  List<NewsArticle> get filteredNews => _filteredNews;

  bool _isSearch = false;
  bool get isSearch => _isSearch;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  final List<NewsArticle> _news = [];
  List<NewsArticle> get news => _news;

  Future<void> getAllRss() async {
    _isLoading = true;
    final news = await _service.getAllNews();
    _news.addAll(news);
    _isLoading = false;
    notifyListeners();
  }

  void changeKeyWord(keyword) {
    for (var item in _news) {
      var newsLower = turkish.toLowerCase(item.title!);
      var keywordLower = turkish.toLowerCase(keyword);
      if (newsLower.contains(keywordLower)) {
        _filteredNews.add(item);
      }
    }
    notifyListeners();
  }

  Future<void> getRssByCategory(String category) async {
    _isLoading = true;
    _news.addAll(await _service.getNewsByCategory(category));
    _isLoading = false;
    notifyListeners();
  }

  void changeSearchState() {
    _isSearch = !_isSearch;
    notifyListeners();
  }
}
