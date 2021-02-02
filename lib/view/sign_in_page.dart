import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';

import '../states/auth_state.dart';
import '../states/sncakbar_message_state.dart';
import '../states/validation_state.dart';
import 'widgets/form_field.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  ValidationState _validator = ValidationState();

  GlobalKey<FormState> _emailKey = GlobalKey<FormState>();
  GlobalKey<FormState> _passKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  AuthState _auth = AuthState();

  @override
  Widget build(BuildContext context) {
    return Consumer<ToastMessage>(
      builder: (BuildContext context, value, Widget child) {
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
                    _buildSignInButton(context),
                  ],
                ),
                signInWithGoogleButton(context)
              ],
            ),
          ),
        );
      },
    );
  }

  Widget get _appBar => AppBar(
        title: Text("Giriş Yap"),
      );

  Widget get _emailField => BuildFormField(
        controller: _emailController,
        formKey: _emailKey,
        label: "Email",
        secure: false,
        validator: (email) => _validator.validateEmail(email),
      );

  Widget get _emptyHeight => SizedBox(height: 16);

  Widget get _passwordField => BuildFormField(
        controller: _passController,
        formKey: _passKey,
        label: "Password",
        secure: true,
        validator: (password) => _validator.validatePassword(password),
      );

  Widget _buildSignInButton(context) => SignInButtonBuilder(
        backgroundColor: Colors.grey[600],
        onPressed: () async {
          if (_emailKey.currentState.validate() && _passKey.currentState.validate()) {
            await _auth.signInWithEmailandPassword(
              context,
              _emailController.text,
              _passController.text,
            );
          } else {}
        },
        text: "Giriş Yap",
        icon: Icons.email,
      );

  Widget signInWithGoogleButton(BuildContext context) => SignInButton(
        Buttons.GoogleDark,
        text: "Google ile Giriş Yap",
        onPressed: () async {
          await _auth.signInWithGoogle(context);
        },
      );
}
