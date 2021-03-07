import 'package:flutter/material.dart';
import '../../states/news_state.dart';

class CategoryField extends StatelessWidget {
  const CategoryField({Key? key, required this.model}) : super(key: key);
  final NewsState model;
  static List<String> categoryUrls = [
    'technology',
    'sports',
    'business',
    'health',
    'entertainment',
    'science',
  ];
  static List<String> categoryNames = [
    'Teknoloji',
    'Spor',
    'Ekonomi',
    'Sağlık',
    'Eğlence',
    'Bilim'
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
          return categoryChip(
              category: categoryUrls[index], text: categoryNames[index]);
        },
        separatorBuilder: (BuildContext context, int index) {
          return emptyWidth();
        },
      );

  SizedBox emptyWidth() => SizedBox(width: 12);

  Widget categoryChip({required final text, final category}) => ActionChip(
        label: Text(text),
        onPressed: () {
          model.news.clear();
          debugPrint(category);
          model.getRssByCategory('$category');
        },
      );
}
