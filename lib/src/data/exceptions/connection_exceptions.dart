// lib/src/data/repositories/connection_exceptions.dart

class ConnectionException implements Exception {
  const ConnectionException([this.message = 'An unknown exception occurred.']);
  final String message;
}
