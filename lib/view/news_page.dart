import 'package:flutter/material.dart';
import 'package:news_demo/constant/constants.dart';
import '../service/navigation_service.dart';
import '../states/news_state.dart';
import 'package:provider/provider.dart';

import 'settings_page.dart';
import 'widgets/category_field.dart';
import 'widgets/news_list_builder.dart';

class NewsPage extends StatelessWidget {
  final NavigationService _navigator = NavigationService();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsState>(
      builder: (BuildContext context, model, Widget? child) {
        return Scaffold(
          appBar: model.isSearch
              ? _searchAppBar(context, model)
              : _normalAppBar(context, model),
          body: _body(model),
        );
      },
    );
  }

  AppBar _searchAppBar(BuildContext context, NewsState model) => AppBar(
        title: TextFormField(controller: _controller),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              model.changeKeyWord(_controller.text);
              _controller.clear();
            },
          ),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              model.changeSearchState();
              model.filteredNews.clear();
            },
          ),
        ],
      );

  AppBar _normalAppBar(BuildContext context, NewsState model) => AppBar(
        title: Text(AppConstant.NEWS),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                model.changeSearchState();
              }),
          settingsIconButton(context),
        ],
      );

  Widget settingsIconButton(BuildContext context) => IconButton(
        icon: Icon(Icons.settings),
        onPressed: () {
          _navigator.goToNewPage(context: context, newPage: SettingsPage());
        },
      );

  Widget _body(model) => Column(
        children: [
          CategoryField(model: model),
          Expanded(child: NewsListViewBuilder(model: model)),
        ],
      );

  SizedBox emptyWidth() => SizedBox(width: 12);
}
