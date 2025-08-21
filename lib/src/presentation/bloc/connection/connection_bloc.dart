// lib/src/presentation/bloc/connection/connection_bloc.dart

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connect/src/domain/models/connection.dart';
import 'package:connect/src/domain/models/connection_request.dart';
import 'package:connect/src/domain/repositories/auth_repository.dart';
import 'package:connect/src/domain/repositories/connection_repository.dart';
import 'package:connect/src/data/exceptions/connection_exceptions.dart';
import 'package:connect/src/presentation/bloc/connection/connection_event.dart';
import 'package:connect/src/presentation/bloc/connection/connection_state.dart';
import 'package:connect/src/presentation/bloc/profile/profile_bloc.dart';

class ConnectionBloc extends Bloc<ConnectionEvent, ConnectionState> {
  ConnectionBloc({
    required ConnectionRepository connectionRepository,
    required ProfileBloc profileBloc,
    required AuthRepository authRepository,
  }) : _connectionRepository = connectionRepository,
       _profileBloc = profileBloc,
       _authRepository = authRepository,
       super(const ConnectionState()) {
    on<ConnectionRequestSent>(_onConnectionRequestSent);
    on<IncomingRequestsSubscriptionRequested>(
      _onIncomingRequestsSubscriptionRequested,
    );
    on<ConnectionRequestAccepted>(_onConnectionRequestAccepted);
    on<ConnectionRequestDeclined>(_onConnectionRequestDeclined);
    on<ConnectionsSubscriptionRequested>(_onConnectionsSubscriptionRequested);
  }

  final ConnectionRepository _connectionRepository;
  final ProfileBloc _profileBloc;
  final AuthRepository _authRepository;

  Future<void> _onConnectionRequestSent(
    ConnectionRequestSent event,
    Emitter<ConnectionState> emit,
  ) async {
    emit(state.copyWith(status: ConnectionStatus.loading));
    try {
      final user = await _authRepository.user.first;
      if (user == null) throw Exception('User not authenticated.');

      final currentUserProfile = _profileBloc.state.selectedProfile;
      if (currentUserProfile == null) {
        throw Exception('Current user profile not found.');
      }

      await _connectionRepository.createConnectionRequest(
        currentUserId: user.uid,
        currentUserProfile: currentUserProfile,
        targetUserId: event.targetUserId,
      );
      emit(state.copyWith(status: ConnectionStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: ConnectionStatus.failure,
          errorMessage: e is ConnectionException ? e.message : e.toString(),
        ),
      );
    }
  }

  Future<void> _onIncomingRequestsSubscriptionRequested(
    IncomingRequestsSubscriptionRequested event,
    Emitter<ConnectionState> emit,
  ) async {
    emit(state.copyWith(status: ConnectionStatus.loading));
    final user = await _authRepository.user.first;
    if (user == null) {
      emit(state.copyWith(status: ConnectionStatus.failure));
      return;
    }

    await emit.forEach<List<ConnectionRequest>>(
      _connectionRepository.getIncomingRequests(userId: user.uid),
      onData: (requests) => state.copyWith(
        status: ConnectionStatus.success,
        incomingRequests: requests,
      ),
      onError: (error, __) => state.copyWith(
        status: ConnectionStatus.failure,
        errorMessage: error is ConnectionException
            ? error.message
            : error.toString(),
      ),
    );
  }

  Future<void> _onConnectionRequestAccepted(
    ConnectionRequestAccepted event,
    Emitter<ConnectionState> emit,
  ) async {
    try {
      await _connectionRepository.acceptRequest(request: event.request);
    } catch (e) {
      emit(
        state.copyWith(
          status: ConnectionStatus.failure,
          errorMessage: e is ConnectionException ? e.message : e.toString(),
        ),
      );
    }
  }

  Future<void> _onConnectionRequestDeclined(
    ConnectionRequestDeclined event,
    Emitter<ConnectionState> emit,
  ) async {
    try {
      await _connectionRepository.declineRequest(requestId: event.requestId);
    } catch (e) {
      emit(
        state.copyWith(
          status: ConnectionStatus.failure,
          errorMessage: e is ConnectionException ? e.message : e.toString(),
        ),
      );
    }
  }

  Future<void> _onConnectionsSubscriptionRequested(
    ConnectionsSubscriptionRequested event,
    Emitter<ConnectionState> emit,
  ) async {
    emit(state.copyWith(status: ConnectionStatus.loading));
    final user = await _authRepository.user.first;
    if (user == null) {
      emit(state.copyWith(status: ConnectionStatus.failure));
      return;
    }

    await emit.forEach<List<Connection>>(
      _connectionRepository.getConnections(userId: user.uid),
      onData: (connections) => state.copyWith(
        status: ConnectionStatus.success,
        connections: connections,
      ),
      onError: (error, __) => state.copyWith(
        status: ConnectionStatus.failure,
        errorMessage: error is ConnectionException
            ? error.message
            : error.toString(),
      ),
    );
  }
}
