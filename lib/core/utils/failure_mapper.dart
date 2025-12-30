import '../error/exceptions.dart';
import '../error/failures.dart';

/// Maps exceptions thrown from the data layer to failures for the domain layer.
///
/// This utility provides a centralized place for exception-to-failure conversion,
/// ensuring consistent error handling across the application.
class FailureMapper {
  /// Converts an [AppException] to a corresponding [Failure].
  static Failure mapExceptionToFailure(AppException exception) {
    switch (exception) {
      // Network exceptions
      case NetworkException():
        return NetworkFailure(exception.message);
      case ServerException():
        return ServerFailure(
          exception.message,
          exception.errorCode,
          exception.statusCode,
        );
      case TimeoutException():
        return TimeoutFailure(exception.message);

      // Auth exceptions
      case AuthException():
        return CredentialFailure(exception.message);
      case UnauthorizedException():
        return UnauthorizedFailure(exception.message);
      case ForbiddenException():
        return ForbiddenFailure(exception.message);

      // Data exceptions
      case NotFoundException():
        return NotFoundFailure(exception.message);
      case DuplicateException():
        return DuplicateFailure(exception.message);
      case ValidationException():
        return ValidationFailure(exception.message, exception.errors);

      // Cache exceptions
      case CacheException():
        return CacheFailure(exception.message);
      case NoCachedDataException():
        return NoCachedDataFailure(exception.message);

      // Input validation exceptions
      case InvalidEmailException():
        return InvalidEmailFailure(exception.message);
      case InvalidPasswordException():
        return InvalidPasswordFailure(exception.message);
      case EmptyInputException():
        return EmptyInputFailure(exception.message);

      // General exceptions
      case ParseException():
        return ParseFailure(exception.message);
      case UnexpectedException():
        return UnexpectedFailure(exception.message);

      default:
        return UnexpectedFailure(exception.message);
    }
  }

  /// Converts any exception (including non-AppException) to a [Failure].
  static Failure mapAnyExceptionToFailure(Object exception) {
    if (exception is AppException) {
      return mapExceptionToFailure(exception);
    } else if (exception is Failure) {
      // Already a failure, return as-is
      return exception;
    } else {
      // Unknown exception, wrap in UnexpectedFailure
      return UnexpectedFailure(exception.toString());
    }
  }
}

/// Extension on [Failure] to get user-friendly messages.
///
/// Use this in the presentation layer to display error messages to users.
extension FailureMessage on Failure {
  /// Returns a user-friendly message for display in the UI.
  ///
  /// By default returns the failure's message, but can be overridden
  /// for specific failure types to provide more context.
  String get userMessage {
    // The failure already contains the user-friendly message in Indonesian
    return message;
  }

  /// Returns a more detailed technical message for logging purposes.
  String get technicalMessage {
    final buffer = StringBuffer()..write(runtimeType.toString());

    if (errorCode != null) {
      buffer.write(' (code: $errorCode)');
    }

    buffer.write(': $message');

    if (this is ServerFailure) {
      final serverFailure = this as ServerFailure;
      if (serverFailure.statusCode != null) {
        buffer.write(' [HTTP ${serverFailure.statusCode}]');
      }
    }

    if (this is ValidationFailure) {
      final validationFailure = this as ValidationFailure;
      if (validationFailure.errors != null) {
        buffer.write('\nValidation errors: ${validationFailure.errors}');
      }
    }

    return buffer.toString();
  }
}

/// Legacy function for backward compatibility.
///
/// Prefer using [Failure.userMessage] extension method instead.
String mapFailureToMessage(Failure failure) {
  return failure.userMessage;
}
