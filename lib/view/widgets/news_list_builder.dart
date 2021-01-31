import 'package:flutter/material.dart';
import 'package:news_demo/model/news_article.dart';
import 'package:news_demo/service/navigation_service.dart';
import 'package:news_demo/states/news_state.dart';

import '../news_detail_page.dart';

class NewsListViewBuilder extends StatelessWidget {
  const NewsListViewBuilder({Key key, this.model}) : super(key: key);
  final NewsState model;
  static NavigationService _navigator = NavigationService();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: model.news.length,
      itemBuilder: (BuildContext context, int index) {
        final news = model.news[index];
        return _touchNews(context, news);
      },
    );
  }

  Widget _touchNews(BuildContext context, final news) {
    return GestureDetector(
      onTap: () => _goNewsDetail(context, news),
      child: _newsCard(context, news),
    );
  }

  Widget _newsCard(BuildContext context, NewsArticle news) {
    return Card(
      child: Row(
        children: [
          _newsImage(news.urlToImage ?? "https://via.placeholder.com/150x100"),
          SizedBox(width: 10),
          _newsTitle(news.title),
          IconButton(
            icon: Icon(Icons.keyboard_arrow_right),
            onPressed: () => _goNewsDetail(context, news),
          )
        ],
      ),
    );
  }

  _newsImage(String url) => Image(
        fit: BoxFit.cover,
        height: 100,
        width: 150,
        image: NetworkImage(url),
      );

  _newsTitle(String title) => Expanded(
        child: Text(
          title,
          overflow: TextOverflow.ellipsis,
          maxLines: 5,
        ),
      );

  _goNewsDetail(final context, NewsArticle news) {
    return _navigator.goToNewPage(context: context, newPage: NewsDetailPage(url: news.url));
  }
}
