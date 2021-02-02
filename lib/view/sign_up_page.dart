import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

import '../states/auth_state.dart';
import '../states/validation_state.dart';
import 'widgets/form_field.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  ValidationState _validator = ValidationState();
  AuthState _auth = AuthState();
  final _emailKey = GlobalKey<FormState>();
  final _passKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flex(
              direction: Axis.vertical,
              children: [
                _emailField,
                _emptyHeight,
                _passwordField,
                _emptyHeight,
                buildSignUpButtonBuilder(context),
              ],
            ),
            signInWithGoogleButton(context)
          ],
        ),
      ),
    );
  }

  Widget get _appBar => AppBar(
        title: Text("Kayıt Ol"),
      );

  Widget get _emailField => BuildFormField(
        controller: _emailController,
        formKey: _emailKey,
        label: "Email",
        secure: false,
        validator: (email) => _validator.validateEmail(email),
      );

  Widget get _emptyHeight => SizedBox(height: 12);

  Widget get _passwordField => BuildFormField(
        controller: _passController,
        formKey: _passKey,
        label: "Password",
        secure: true,
        validator: (password) => _validator.validatePassword(password),
      );

  Widget buildSignUpButtonBuilder(BuildContext context) => SignInButtonBuilder(
        backgroundColor: Colors.grey,
        text: "Kayıt Ol",
        icon: Icons.person_add,
        onPressed: () {
          if (_emailKey.currentState.validate() && _passKey.currentState.validate()) {
            _auth.newRegister(context, _emailController.text, _passController.text);
          } else {}
        },
      );

  Widget signInWithGoogleButton(BuildContext context) => SignInButton(
        Buttons.GoogleDark,
        text: "Google ile Giriş Yap",
        onPressed: () async {
          await _auth.signInWithGoogle(context);
        },
      );
}
