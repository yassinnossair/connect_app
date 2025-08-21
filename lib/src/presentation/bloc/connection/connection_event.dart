// lib/src/presentation/bloc/connection/connection_event.dart

import 'package:equatable/equatable.dart';
import 'package:connect/src/domain/models/connection_request.dart';

abstract class ConnectionEvent extends Equatable {
  const ConnectionEvent();

  @override
  List<Object> get props => [];
}

class ConnectionRequestSent extends ConnectionEvent {
  const ConnectionRequestSent({required this.targetUserId});
  final String targetUserId;

  @override
  List<Object> get props => [targetUserId];
}

class IncomingRequestsSubscriptionRequested extends ConnectionEvent {}

class ConnectionRequestAccepted extends ConnectionEvent {
  const ConnectionRequestAccepted({required this.request});
  final ConnectionRequest request;

  @override
  List<Object> get props => [request];
}

class ConnectionRequestDeclined extends ConnectionEvent {
  const ConnectionRequestDeclined({required this.requestId});
  final String requestId;

  @override
  List<Object> get props => [requestId];
}

class ConnectionsSubscriptionRequested extends ConnectionEvent {}
