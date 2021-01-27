import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperPage extends StatelessWidget {
  const DeveloperPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Mustafa Akil",
              style: TextStyle(fontSize: 40, color: Colors.black54),
            ),
            buildSocailButton(
              icon: FontAwesomeIcons.instagram,
              text: "İnstagram",
              url: "https://www.instagram.com/mustafaakilll/",
              color: Color(0xffcd486b),
            ),
            buildSocailButton(
              icon: FontAwesomeIcons.twitter,
              text: "twitter",
              url: "https://twitter.com/Mustafaakill",
              color: Color(0xff1DA1F2),
            ),
            buildSocailButton(
              icon: FontAwesomeIcons.github,
              text: "Github",
              url: "https://github.com/Apooness/",
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  Widget get _appbar {
    return AppBar(
      title: Text("Geliştirici"),
    );
  }

  Widget buildSocailButton({final text, final url, final icon, final color}) {
    return SignInButtonBuilder(
      backgroundColor: color,
      onPressed: () => launch(url),
      text: text,
      icon: icon,
    );
  }
}
