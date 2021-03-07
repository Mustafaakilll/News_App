import '../service/auth_service.dart';

class AuthState {
  final AuthService _auth = AuthService();

  Future<void> signInWithEmailandPassword(context, email, password) async {
    await _auth.signInWithEmailandPassword(
        context: context, email: email, password: password);
  }

  Future<void> signInWithGoogle(context) async {
    await _auth.signInGmail(context: context);
  }

  Future<void> newRegister(context, email, password) async {
    await _auth.registerNew(context: context, email: email, password: password);
  }

  Future<void> logOut(context) async {
    await _auth.logOut(context);
  }
}
