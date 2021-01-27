import 'package:flutter/material.dart';

///https://medium.com/flutter-community/firebase-auth-exceptions-handling-flutter-54ab59c2853d
///TODO:Error Handling
class ToastMessage with ChangeNotifier {
  String _message = "";

  String get message => _message;

  changeSnackbarMessage(String text) {
    _message = text;
    notifyListeners();
  }
}
