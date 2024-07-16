class MunchieException implements Exception {
  final String message;
  MunchieException(this.message);

  @override
  String toString() => 'MunchieException: $message';
}
