import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

class HttpService {
  final _url = 'https://t24.com.tr/rss';

  Future<RssFeed> getAllNews() async {
    try {
      final response = await http.get("https://t24.com.tr/rss");

      final _rssResponse = RssFeed.parse(response.body);
      switch (response.statusCode) {
        case 200:
          return _rssResponse;
        default:
          throw Exception(response.body.toString());
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  Future<RssFeed> getNewsByCategory(String category) async {
    try {
      final response = await http.get("$_url/haber/$category");
      final _rssBody = response.body;

      final _rssResponse = RssFeed.parse(_rssBody);
      switch (response.statusCode) {
        case 200:
          return _rssResponse;
        default:
          throw Exception(response.body.toString());
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }
}

class Client {}
