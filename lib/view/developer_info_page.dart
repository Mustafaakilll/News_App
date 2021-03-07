import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_demo/constant/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperPage extends StatelessWidget {
  const DeveloperPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppConstant.NAME_SURNAME,
              style: TextStyle(fontSize: 40, color: Colors.black54),
            ),
            buildSocailButton(
              icon: FontAwesomeIcons.instagram,
              text: AppConstant.INSTAGRAM,
              url: AppConstant.INSTAGRAM_LINK,
              color: Color(0xffcd486b),
            ),
            buildSocailButton(
              icon: FontAwesomeIcons.twitter,
              text: AppConstant.TWITTER,
              url: AppConstant.TWITTER_LINK,
              color: Color(0xff1DA1F2),
            ),
            buildSocailButton(
              icon: FontAwesomeIcons.github,
              text: AppConstant.GITHUB,
              url: AppConstant.GITHUB_LINK,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  AppBar get _appbar {
    return AppBar(
      title: Text(AppConstant.DEVELOPER),
    );
  }

  Widget buildSocailButton(
      {required final text,
      required final url,
      required final icon,
      required final color}) {
    return SignInButtonBuilder(
      backgroundColor: color,
      onPressed: () => launch(url),
      text: text,
      icon: icon,
    );
  }
}
