import 'package:flutter/material.dart';
import 'package:news_demo/service/navigation_service.dart';
import 'package:news_demo/states/news_state.dart';
import 'package:provider/provider.dart';

import 'settings_page.dart';
import 'widgets/category_field.dart';
import 'widgets/news_list_builder.dart';

class NewsPage extends StatelessWidget {
  final NavigationService _navigator = NavigationService();
  static List<String> categoryUrls = [
    "bilim-teknoloji",
    "spor",
    "ekonomi",
    "saglik",
    "cevre",
    "yasam",
    "soylesi",
    "sosyal-guvenlik",
    "medya",
    "magazin",
    "kultur-sanat",
    "egitim",
    "dunya",
    "koronavirus",
    "gundem"
  ];
  static List<String> categoryNames = [
    "Teknoloji",
    "Spor",
    "Ekonomi",
    "Sağlık",
    "Çevre",
    "Yaşam",
    "Söyleşi",
    "Sosyal Güvenlik",
    "Medya",
    "Magazin",
    "Kültür Sanat",
    "Eğitim",
    "Dünya",
    "KoronaVirüs",
    "Gündem"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _body(),
    );
  }

  Widget _appBar(BuildContext context) => AppBar(
        title: Text("Haberler"),
        actions: [
          settingsIconButton(context),
        ],
      );

  Widget settingsIconButton(BuildContext context) => IconButton(
        icon: Icon(Icons.settings),
        onPressed: () {
          _navigator.goToNewPage(context: context, newPage: SettingsPage());
        },
      );

  Widget _body() => Consumer<NewsState>(
        builder: (BuildContext context, model, Widget child) {
          if (model.isLoading == true) {
            return Center(child: CircularProgressIndicator());
          }
          if (model.news.items.length == 0) {
            return Text("No Data");
          }

          return Column(
            children: [
              CategoryField(model: model),
              Expanded(child: NewsListViewBuilder(model: model)),
            ],
          );
        },
      );
  SizedBox emptyWidth() => SizedBox(width: 12);
}
