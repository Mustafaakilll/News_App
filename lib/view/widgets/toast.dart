import 'package:flutter/material.dart';
import 'package:news_demo/states/sncakbar_message_state.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShowFlutterToast {
  void showInfoToast({BuildContext context}) {
    final toastMessage = Provider.of<ToastMessage>(context).message;
    Fluttertoast.showToast(
      msg: toastMessage,
      backgroundColor: Colors.grey,
      fontSize: 16,
      gravity: ToastGravity.BOTTOM,
    );
  }
}
