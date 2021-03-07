import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:news_demo/constant/constants.dart';
import 'package:provider/provider.dart';

import '../states/auth_state.dart';
import '../states/sncakbar_message_state.dart';
import '../states/validation_state.dart';
import 'widgets/form_field.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late ValidationState _validator;
  late GlobalKey<FormState> _emailKey;

  late GlobalKey<FormState> _passKey;
  late TextEditingController _emailController;
  late TextEditingController _passController;
  late AuthState _auth;

  @override
  void initState() {
    _validator = ValidationState();
    _emailKey = GlobalKey<FormState>();
    _passKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passController = TextEditingController();
    _auth = AuthState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ToastMessage>(
      builder: (BuildContext context, value, Widget? child) {
        return Scaffold(
          appBar: _appBar as PreferredSizeWidget?,
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
        title: Text(AppConstant.SIGN_IN),
      );

  Widget get _emailField => BuildFormField(
        controller: _emailController,
        formKey: _emailKey,
        label: AppConstant.EMAIL,
        secure: false,
        validator: (email) => _validator.validateEmail(email),
      );

  Widget get _emptyHeight => SizedBox(height: 16);

  Widget get _passwordField => BuildFormField(
        controller: _passController,
        formKey: _passKey,
        label: AppConstant.PASSWORD,
        secure: true,
        validator: (password) => _validator.validatePassword(password),
      );

  Widget _buildSignInButton(context) => SignInButtonBuilder(
        backgroundColor: Colors.grey[600]!,
        onPressed: () async {
          if (_emailKey.currentState!.validate() &&
              _passKey.currentState!.validate()) {
            await _auth.signInWithEmailandPassword(
              context,
              _emailController.text,
              _passController.text,
            );
          } else {}
        },
        text: AppConstant.SIGN_IN,
        icon: Icons.email,
      );

  Widget signInWithGoogleButton(BuildContext context) => SignInButton(
        Buttons.GoogleDark,
        text: AppConstant.LOGIN_GOOGLE,
        onPressed: () async {
          await _auth.signInWithGoogle(context);
        },
      );
}
