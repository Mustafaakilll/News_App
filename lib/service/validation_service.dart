class ValidationService {
  String? validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    var regex = RegExp(pattern as String);
    if (!regex.hasMatch(value)) {
      ('Geçerli Bir Email Giriniz');
    } else {
      null;
    }
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Bu Kısım Boş Bırakılamaz';
    } else if (value.length < 6) {
      return 'Şifre en az 6 karakter olmalıdır';
    } else {
      return null;
    }
  }
}
