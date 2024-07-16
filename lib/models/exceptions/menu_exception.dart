class MenuException implements Exception {
  final String message;
  MenuException(this.message);

  @override
  String toString() => 'MenuException: $message';
}
