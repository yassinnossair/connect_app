// lib/src/domain/repositories/connection_repository.dart

import 'package:connect/src/domain/models/connection.dart';
import 'package:connect/src/domain/models/connection_request.dart';
import 'package:connect/src/domain/models/user_profile.dart';

abstract class ConnectionRepository {
  Future<void> createConnectionRequest({
    required String currentUserId,
    required UserProfile currentUserProfile,
    required String targetUserId,
  });

  Stream<List<ConnectionRequest>> getIncomingRequests({required String userId});

  Future<void> acceptRequest({required ConnectionRequest request});

  Future<void> declineRequest({required String requestId});

  Stream<List<Connection>> getConnections({required String userId});
}
