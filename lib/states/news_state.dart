import 'package:flutter/material.dart';

import '../data/http.dart';
import '../model/news_article.dart';

class NewsState extends ChangeNotifier {
  HttpService _service = HttpService();

  String _keyword;
  String get keyWord => _keyword;

  List<NewsArticle> _filteredNews = [];
  List<NewsArticle> get filteredNews => _filteredNews;

  bool _isSearch = false;
  bool get isSearch => _isSearch;

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

  void changeKeyWord(keyword) {
    _keyword = keyWord;
    for (var item in _news) {
      if (item.title.contains(keyword)) {
        _filteredNews.add(item);
      }
    }
    notifyListeners();
  }

  Future<void> getRssByCategory(String category) async {
    _isLoading = true;
    _news = await _service.getNewsByCategory(category);
    _isLoading = false;
    notifyListeners();
  }

  void changeSearchState() {
    _isSearch = !_isSearch;

    notifyListeners();
  }
}
