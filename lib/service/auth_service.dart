import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../states/sncakbar_message_state.dart';
import '../view/main_page.dart';
import '../view/news_page.dart';
import '../view/widgets/toast.dart';
import 'navigation_service.dart';
import '../constant/app_constants.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final NavigationService _navigator = NavigationService();

  // ignore: missing_return
  Future<void> signInWithEmailandPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    final showSnackBar = ShowFlutterToast();
    final value = Provider.of<ToastMessage>(context, listen: false);
    try {
      var userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user!;

      value.changeSnackbarMessage('Hoş Geldiniz ${user.email}');

      showSnackBar.showInfoToast(context: context);
      _navigator.replaceNewPage(context: context, newPage: NewsPage());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        value.changeSnackbarMessage(AppConstant.USER_NOT_FOUND);
        showSnackBar.showInfoToast(context: context);
      } else if (e.code == 'wrong-password') {
        value.changeSnackbarMessage(AppConstant.WRONG_PASSWORD);

        showSnackBar.showInfoToast(context: context);
      }
    }
  }

  Future<void> signInGmail({required BuildContext context}) async {
    final googleUser = (await GoogleSignIn().signIn())!;
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    ) as GoogleAuthCredential;
    final userCredential = await _auth.signInWithCredential(credential);
    final user = userCredential.user!;
    final value = Provider.of<ToastMessage>(context, listen: false);
    final showSnackBar = ShowFlutterToast();

    value.changeSnackbarMessage('Hoşgeldin ${user.displayName}');

    showSnackBar.showInfoToast(context: context);

    _navigator.replaceNewPage(context: context, newPage: NewsPage());
  }

  Future<void> registerNew(
      {required BuildContext context,
      required final email,
      required final password}) async {
    final value = Provider.of<ToastMessage>(context, listen: false);
    final showSnackBar = ShowFlutterToast();

    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user!;

      // ignore: unnecessary_null_comparison
      if (user != null) {
        value.changeSnackbarMessage('Merhaba $email');
        showSnackBar.showInfoToast(context: context);
        _navigator.replaceNewPage(context: context, newPage: NewsPage());
      } else {
        value.changeSnackbarMessage('Hata Oldu');
        showSnackBar.showInfoToast(context: context);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        value.changeSnackbarMessage(AppConstant.WEAK_PASSWORD);
        showSnackBar.showInfoToast(context: context);
      } else if (e.code == 'emaıl-already-ın-use') {
        value.changeSnackbarMessage(AppConstant.INVALID_EMAIL);
        showSnackBar.showInfoToast(context: context);
      }
    } catch (er) {
      value.changeSnackbarMessage('Bilinmeyen Hata:${er.toString()}');
      showSnackBar.showInfoToast(context: context);
    }
  }

  Future<void> logOut(context) async {
    await _auth.signOut();
    _navigator.replaceNewPage(context: context, newPage: MainPage());
  }
}
