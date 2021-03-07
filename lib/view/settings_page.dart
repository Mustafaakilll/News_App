import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:news_demo/constant/constants.dart';
import '../service/navigation_service.dart';
import '../states/auth_state.dart';
import '../states/theme_state.dart';
import 'developer_info_page.dart';
import 'main_page.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SettingsPage extends StatelessWidget {
  final NavigationService _navigator = NavigationService();
  final AuthState _auth = AuthState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flex(
              direction: Axis.vertical,
              children: [
                developerInfoButton(context),
                themeButton(),
              ],
            ),
            logOutButton(context)
          ],
        ),
      ),
    );
  }

  AppBar _appBar() => AppBar(
        title: Text(AppConstant.SETTINGS),
      );

  Widget developerInfoButton(BuildContext context) => ElevatedButton(
        onPressed: () {
          _navigator.goToNewPage(context: context, newPage: DeveloperPage());
        },
        child: Text(
          AppConstant.ABOUT_DEVELOPER,
          style: TextStyle(color: Colors.white),
        ),
      );

  Consumer<ThemeState> themeButton() => Consumer<ThemeState>(
        builder: (BuildContext context, value, Widget? child) {
          return SwitchListTile(
            title: Text(AppConstant.LIGHT_THEME),
            value: value.isLightTheme,
            onChanged: (val) {
              value.toggleThemeData();
            },
          );
        },
      );

  Widget logOutButton(BuildContext context) {
    return SignInButtonBuilder(
      backgroundColor: Theme.of(context).buttonTheme.colorScheme!.primary,
      onPressed: () {
        _auth.logOut(context);
        _navigator.replaceNewPage(context: context, newPage: MainPage());
      },
      icon: Icons.logout,
      text: AppConstant.LOG_OUT,
      fontSize: Theme.of(context).textTheme.button!.fontSize!,
    );
  }
}
