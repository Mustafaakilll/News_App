import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:news_demo/service/navigation_service.dart';

import 'sign_in_page.dart';
import 'sign_up_page.dart';

class MainPage extends StatelessWidget {
  final NavigationService _navigator = NavigationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buttonBuilder(
              color: Colors.orange,
              context: context,
              icon: Icons.email,
              newPage: SignInPage(),
              text: "Giriş",
            ),
            SizedBox(height: 50),
            _buttonBuilder(
              context: context,
              color: Colors.blue,
              icon: Icons.person_add_alt_1,
              newPage: SignUpPage(),
              text: "Kayıt Ol",
            )
          ],
        ),
      ),
    );
  }

  Widget get _appBar => AppBar(
        title: Text("Hoş Geldiniz"),
      );

  Widget _buttonBuilder({context, newPage, color, text, icon}) => SignInButtonBuilder(
        height: 50,
        onPressed: () {
          _navigator.goToNewPage(context: context, newPage: newPage);
        },
        backgroundColor: color,
        text: text,
        icon: icon,
      );

  Widget space({double width = 0, double height = 0}) => SizedBox(width: width, height: height);
}
