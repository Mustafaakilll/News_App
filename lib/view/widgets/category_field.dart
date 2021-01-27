import 'package:flutter/material.dart';
import 'package:news_demo/states/news_state.dart';

class CategoryField extends StatelessWidget {
  const CategoryField({Key key, this.model}) : super(key: key);
  final NewsState model;
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      height: 50,
      child: _categoryListView(),
    );
  }

  Widget _categoryListView() => ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: categoryNames.length,
        itemBuilder: (BuildContext context, int index) {
          return categoryChip(category: categoryUrls[index], text: categoryNames[index]);
        },
        separatorBuilder: (BuildContext context, int index) {
          return emptyWidth();
        },
      );

  SizedBox emptyWidth() => SizedBox(width: 12);

  Widget categoryChip({final text, final category}) => ActionChip(
        label: Text(text),
        onPressed: () {
          model.getRssByCategory("$category");
        },
      );
}
