import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailPage extends StatelessWidget {
  const NewsDetailPage({Key? key, required this.url, required this.news_title})
      : super(key: key);
  final url;
  final String news_title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _appbar, body: _body());
  }

  AppBar get _appbar => AppBar(
        title: Text(
          news_title,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          _shareIcon,
        ],
      );

  Widget _body() => WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      );

  Widget get _shareIcon => IconButton(
        icon: Icon(Icons.share),
        onPressed: _share,
      );

  Future<void> _share() async {
    await Share.share(url);
  }
}
