import '../../Constant/app_strings.dart';

class CustomException implements Exception {
  final message;
  final prefix;

  CustomException([this.message, this.prefix]);

  @override
  String toString() {
    return "$prefix$message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException([String? message]) : super(message, CustomExceptionStrings.fetchDataException);
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message,CustomExceptionStrings.badRequestException);
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message]) : super(message,CustomExceptionStrings.unAuthorisedException );
}

class InvalidInputException extends CustomException {
  InvalidInputException([String? message]) : super(message,CustomExceptionStrings.invalidInputException );
}