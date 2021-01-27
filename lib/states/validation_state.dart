import 'package:news_demo/service/validation_service.dart';

class ValidationState {
  ValidationService _validator = ValidationService();

  ValidationService get validator => _validator;

  validateEmail(value) {
    return _validator.validateEmail(value);
  }

  validatePassword(value) {
    return _validator.validatePassword(value);
  }
}
