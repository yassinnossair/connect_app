// lib/src/data/repositories/connection_exceptions.dart

/// Thrown when any connection-related operation fails.
class ConnectionException implements Exception {
  const ConnectionException([this.message = 'An unknown exception occurred.']);

  final String message;
}