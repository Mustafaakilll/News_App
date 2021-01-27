import 'package:flutter/material.dart';
import 'package:news_demo/service/navigation_service.dart';
import 'package:news_demo/states/news_state.dart';

import '../news_detail_page.dart';
import 'package:webfeed/domain/rss_item.dart';

class NewsListViewBuilder extends StatelessWidget {
  const NewsListViewBuilder({Key key, this.model}) : super(key: key);
  final NewsState model;
  static NavigationService _navigator = NavigationService();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: model.news.items.length,
      itemBuilder: (BuildContext context, int index) {
        final news = model.news.items[index];
        return _touchNews(context, news);
      },
    );
  }

  Widget _touchNews(BuildContext context, RssItem news) {
    return GestureDetector(
      onTap: () => _goNewsDetail(context, news),
      child: _newsCard(context, news),
    );
  }

  Widget _newsCard(BuildContext context, RssItem news) {
    return Card(
      child: Row(
        children: [
          _newsImage(news.enclosure.url),
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

  _goNewsDetail(final context, final news) {
    return _navigator.goToNewPage(context: context, newPage: NewsDetailPage(url: news.link));
  }
}
