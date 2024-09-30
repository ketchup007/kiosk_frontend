class AppException implements Exception {
  final String message;
  final String? prefix;

  AppException(this.message, [this.prefix]);

  @override
  String toString() {
    if (prefix != null) {
      return '$prefix: $message';
    } else {
      return message;
    }
  }
}

class MenuException extends AppException {
  MenuException(String message) : super(message, 'MenuException');
}

class MunchieException extends AppException {
  MunchieException(String message) : super(message, 'MunchieException');
}

class OrderException extends AppException {
  OrderException(String message) : super(message, 'OrderException');
}

class ApsException extends AppException {
  ApsException(String message) : super(message, 'ApsException');
}

class ItemDescriptionException extends AppException {
  ItemDescriptionException(String message) : super(message, 'ItemDescriptionException');
}
