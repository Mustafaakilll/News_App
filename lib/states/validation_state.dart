import '../service/validation_service.dart';

class ValidationState {
  final ValidationService _validator = ValidationService();

  ValidationService get validator => _validator;

  String? validateEmail(value) {
    return _validator.validateEmail(value);
  }

  String? validatePassword(value) {
    return _validator.validatePassword(value);
  }
}
