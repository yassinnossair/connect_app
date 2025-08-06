// lib/src/presentation/bloc/connection/connection_state.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:connect/src/domain/models/connection.dart';
import 'package:connect/src/domain/models/connection_request.dart';

part 'connection_state.freezed.dart';

enum ConnectionStatus { initial, loading, success, failure }

@freezed
class ConnectionState with _$ConnectionState {
  const factory ConnectionState({
    @Default(ConnectionStatus.initial) ConnectionStatus status,
    @Default([]) List<ConnectionRequest> incomingRequests,
    @Default([]) List<Connection> connections,
    String? errorMessage,
  }) = _ConnectionState;
}