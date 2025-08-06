// lib/src/presentation/bloc/connection/connection_event.dart

import 'package:equatable/equatable.dart';
// NEW: Import the model so this file knows what a ConnectionRequest is.
import 'package:connect/src/domain/models/connection_request.dart';

abstract class ConnectionEvent extends Equatable {
  const ConnectionEvent();

  @override
  List<Object> get props => [];
}

/// Event fired when a user scans a QR code and sends a request.
class ConnectionRequestSent extends ConnectionEvent {
  const ConnectionRequestSent({required this.targetUserId});
  final String targetUserId;

  @override
  List<Object> get props => [targetUserId];
}

/// Event to subscribe to the stream of incoming connection requests.
class IncomingRequestsSubscriptionRequested extends ConnectionEvent {}

/// Event fired when the user accepts a connection request.
class ConnectionRequestAccepted extends ConnectionEvent {
  const ConnectionRequestAccepted({required this.request});
  final ConnectionRequest request;

  @override
  List<Object> get props => [request];
}

/// Event fired when the user declines a connection request.
class ConnectionRequestDeclined extends ConnectionEvent {
  const ConnectionRequestDeclined({required this.requestId});
  final String requestId;

  @override
  List<Object> get props => [requestId];
}

class ConnectionsSubscriptionRequested extends ConnectionEvent {}