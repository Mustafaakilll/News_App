import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:news_demo/constant/app_constants.dart';

import '../states/auth_state.dart';
import '../states/validation_state.dart';
import 'widgets/form_field.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late ValidationState _validator;
  late AuthState _auth;
  late GlobalKey<FormState> _emailKey;
  late GlobalKey<FormState> _passKey;
  late TextEditingController _emailController;
  late TextEditingController _passController;

  @override
  void initState() {
    _auth = AuthState();
    _validator = ValidationState();
    _emailKey = GlobalKey<FormState>();
    _passKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text(AppConstant.SIGN_UP),
      );

  Widget get _emailField => BuildFormField(
        controller: _emailController,
        formKey: _emailKey,
        label: AppConstant.EMAIL,
        secure: false,
        validator: (email) => _validator.validateEmail(email),
      );

  Widget get _emptyHeight => SizedBox(height: 12);

  Widget get _passwordField => BuildFormField(
        controller: _passController,
        formKey: _passKey,
        label: AppConstant.PASSWORD,
        secure: true,
        validator: (password) => _validator.validatePassword(password),
      );

  Widget buildSignUpButtonBuilder(BuildContext context) => SignInButtonBuilder(
        backgroundColor: Colors.grey,
        text: AppConstant.SIGN_UP,
        icon: Icons.person_add,
        onPressed: () {
          if (_emailKey.currentState!.validate() &&
              _passKey.currentState!.validate()) {
            _auth.newRegister(
                context, _emailController.text, _passController.text);
          } else {}
        },
      );

  Widget signInWithGoogleButton(BuildContext context) => SignInButton(
        Buttons.GoogleDark,
        text: AppConstant.LOGIN_GOOGLE,
        onPressed: () async {
          await _auth.signInWithGoogle(context);
        },
      );
}
