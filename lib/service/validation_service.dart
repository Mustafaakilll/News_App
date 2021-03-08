import '../constant/app_constants.dart';

class ValidationService {
  String? validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    var regex = RegExp(pattern as String);
    if (!regex.hasMatch(value)) {
      return AppConstant.VALID_EMAIL;
    } else {
      null;
    }
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return AppConstant.EMPTY_FIELD;
    } else if (value.length < 6) {
      return AppConstant.PASSWORD_LENGTH;
    } else {
      return null;
    }
  }
}
