part of exchange;

class DataException implements Exception {
  final String message;

  DataException(this.message);

  @override
  String toString() => 'DataExcepetion: $message';
}
