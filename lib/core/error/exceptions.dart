class ServerException implements Exception {}

class CacheException implements Exception {}

class SerializationException implements Exception {}

class UnverifiedUserException implements Exception {}

class NeedToLoginException implements Exception {}

class ValidationException implements Exception {
  final Map<String, List<String>> errors;
  ValidationException({required this.errors});
}

class SingleMessageReturnException implements Exception {
  final String message;
  SingleMessageReturnException({required this.message});
}

class PhoneNotRegisteredException extends SingleMessageReturnException {
  PhoneNotRegisteredException()
    : super(message: 'Phone number is not registered. Register to continue.');
}
