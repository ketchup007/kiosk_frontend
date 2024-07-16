class ProductException implements Exception {
  final String message;
  ProductException(this.message);

  @override
  String toString() => 'ProductException: $message';
}
