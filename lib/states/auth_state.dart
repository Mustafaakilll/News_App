import '../service/auth_service.dart';

class AuthState {
  AuthService _auth = AuthService();

  AuthService get authService => _auth;

  signInWithEmailandPassword(context, email, password) async {
    await _auth.signInWithEmailandPassword(context: context, email: email, password: password);
  }

  signInWithGoogle(context) async {
    await _auth.signInGmail(context: context);
  }

  newRegister(context, email, password) async {
    await _auth.registerNew(context: context, email: email, password: password);
  }

  logOut(context) async {
    await _auth.logOut(context);
  }
}
