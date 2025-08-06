// lib/src/domain/repositories/connection_repository.dart

import 'package:connect/src/domain/models/connection.dart';
import 'package:connect/src/domain/models/connection_request.dart';
import 'package:connect/src/domain/models/user_profile.dart';

abstract class ConnectionRepository {
  /// Creates a new connection request from the [currentUser] to the [targetUser].
  Future<void> createConnectionRequest({
    required String currentUserId,
    required UserProfile currentUserProfile,
    required String targetUserId,
  });

  /// Retrieves a real-time stream of incoming connection requests for the [userId].
  Stream<List<ConnectionRequest>> getIncomingRequests({required String userId});

  /// Accepts a connection request. This will create a new [Connection] document
  /// for both users and update the request status.
  Future<void> acceptRequest({required ConnectionRequest request});

  /// Declines a connection request by updating its status.
  Future<void> declineRequest({required String requestId});

  /// Retrieves a real-time stream of accepted connections for the [userId].
  Stream<List<Connection>> getConnections({required String userId});
}