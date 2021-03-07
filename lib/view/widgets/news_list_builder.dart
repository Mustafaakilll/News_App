import 'package:flutter/material.dart';
import 'package:news_demo/constant/constants.dart';

import '../../model/news_article.dart';
import '../../service/navigation_service.dart';
import '../../states/news_state.dart';
import '../news_detail_page.dart';

class NewsListViewBuilder extends StatefulWidget {
  const NewsListViewBuilder({Key? key, required this.model}) : super(key: key);
  final NewsState model;

  @override
  _NewsListViewBuilderState createState() => _NewsListViewBuilderState();
}

class _NewsListViewBuilderState extends State<NewsListViewBuilder> {
  final NavigationService _navigator = NavigationService();

  @override
  Widget build(BuildContext context) {
    if (widget.model.isLoading) Center(child: CircularProgressIndicator());

    if (widget.model.news.isEmpty) Center(child: Text(AppConstant.NO_DATA));

    if (widget.model.isSearch) {
      return ListView.builder(
        itemCount: widget.model.filteredNews.length,
        itemBuilder: (BuildContext context, int index) {
          final _filteredNews = widget.model.filteredNews[index];
          return _touchNews(context, _filteredNews);
        },
      );
    } else {
      return ListView.builder(
        itemCount: widget.model.news.length,
        itemBuilder: (BuildContext context, int index) {
          final news = widget.model.news[index];
          return _touchNews(context, news);
        },
      );
    }
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
          _newsImage(news.urlToImage ?? AppConstant.PLACEHOLDER_URL),
          SizedBox(width: 10),
          _newsTitle(news.title!),
          IconButton(
            icon: Icon(Icons.keyboard_arrow_right),
            onPressed: () => _goNewsDetail(context, news),
          )
        ],
      ),
    );
  }

  Widget _newsImage(String url) => Image(
        fit: BoxFit.cover,
        height: 100,
        width: 150,
        image: NetworkImage(url),
      );

  Widget _newsTitle(String title) => Expanded(
        child: Text(
          title,
          overflow: TextOverflow.ellipsis,
          maxLines: 5,
        ),
      );

  dynamic _goNewsDetail(final context, NewsArticle news) {
    return _navigator.goToNewPage(
        context: context,
        newPage: NewsDetailPage(
          url: news.url,
          news_title: news.title!,
        ));
  }
}
