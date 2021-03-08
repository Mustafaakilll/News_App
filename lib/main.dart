import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
// ignore: library_prefixes
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:provider/provider.dart';

import 'states/news_state.dart';
import 'states/sncakbar_message_state.dart';
import 'states/theme_state.dart';
import 'view/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final appDocumentaryDirectory =
      await pathProvider.getApplicationDocumentsDirectory();

  Hive.init(appDocumentaryDirectory.path);

  final settings = await Hive.openBox('theme');
  bool isLightTheme = settings.get('isLightTheme') ?? true;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => ThemeState(isLightTheme: isLightTheme)),
        ChangeNotifierProvider(create: (_) => ToastMessage()),
        ChangeNotifierProvider<NewsState>(
          create: (context) => NewsState()..getAllRss(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Provider.of<ThemeState>(context).themeData(),
      home: MainPage(),
    );
  }
}
