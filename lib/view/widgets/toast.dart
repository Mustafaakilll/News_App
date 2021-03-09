import 'package:flutter/material.dart';
import '../../states/sncakbar_message_state.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShowFlutterToast {
  void showInfoToast({required BuildContext context}) {
    final toastMessage =
        Provider.of<ToastMessage>(context, listen: false).message;
    Fluttertoast.showToast(
      msg: toastMessage,
      backgroundColor: Colors.grey,
      fontSize: 16,
      gravity: ToastGravity.BOTTOM,
    );
  }
}
