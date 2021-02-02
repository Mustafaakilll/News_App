import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../states/sncakbar_message_state.dart';
import '../view/main_page.dart';
import '../view/news_page.dart';
import '../view/widgets/toast.dart';
import 'navigation_service.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  NavigationService _navigator = NavigationService();

  // ignore: missing_return
  Future<UserCredential> signInWithEmailandPassword(
      {String email, String password, BuildContext context}) async {
    final showSnackBar = ShowFlutterToast();
    final value = Provider.of<ToastMessage>(context, listen: false);
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User user = userCredential.user;

      value.changeSnackbarMessage("Hoş Geldiniz ${user.email}");

      showSnackBar.showInfoToast(context: context);
      _navigator.replaceNewPage(context: context, newPage: NewsPage());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        value.changeSnackbarMessage("Hata: Kullanıcı Bulunamadı");
        showSnackBar.showInfoToast(context: context);
      } else if (e.code == 'wrong-password') {
        value.changeSnackbarMessage("Hata: Şifre Hatalı");

        showSnackBar.showInfoToast(context: context);
      }
    }
  }

  signInGmail({BuildContext context}) async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final UserCredential userCredential = await _auth.signInWithCredential(credential);
    final User user = userCredential.user;
    final value = Provider.of<ToastMessage>(context, listen: false);
    final showSnackBar = ShowFlutterToast();

    value.changeSnackbarMessage("Hoşgeldin ${user.displayName}");

    showSnackBar.showInfoToast(context: context);

    _navigator.replaceNewPage(context: context, newPage: NewsPage());
  }

  registerNew({BuildContext context, final email, final password}) async {
    final value = Provider.of<ToastMessage>(context, listen: false);
    final showSnackBar = ShowFlutterToast();

    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User user = userCredential.user;

      if (user != null) {
        value.changeSnackbarMessage("Merhaba $email");
        showSnackBar.showInfoToast(context: context);
        _navigator.replaceNewPage(context: context, newPage: NewsPage());
      } else {
        value.changeSnackbarMessage("Hata Oldu");
        showSnackBar.showInfoToast(context: context);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        value.changeSnackbarMessage("Hata: Zayıf Parola");
        showSnackBar.showInfoToast(context: context);
      } else if (e.code == 'emaıl-already-ın-use') {
        value.changeSnackbarMessage("Hata: Bu Email Kullanılmaktadır");
        showSnackBar.showInfoToast(context: context);
      }
    } catch (er) {
      value.changeSnackbarMessage("Bilinmeyen Hata:${er.toString()}");
      showSnackBar.showInfoToast(context: context);
    }
  }

  logOut(context) async {
    await _auth.signOut();
    _navigator.replaceNewPage(context: context, newPage: MainPage());
  }
}
