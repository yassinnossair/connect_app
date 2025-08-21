// lib/src/data/repositories/connection_repository_impl.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:connect/src/data/exceptions/connection_exceptions.dart';
import 'package:connect/src/domain/models/connection.dart';
import 'package:connect/src/domain/models/connection_request.dart';
import 'package:connect/src/domain/models/user_profile.dart';
import 'package:connect/src/domain/repositories/connection_repository.dart';

class ConnectionRepositoryImpl implements ConnectionRepository {
  ConnectionRepositoryImpl({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  static const String _requestsCollection = 'connection_requests';
  static const String _connectionsCollection = 'connections';
  static const String _usersCollection = 'users';

  @override
  Future<void> createConnectionRequest({
    required String currentUserId,
    required UserProfile currentUserProfile,
    required String targetUserId,
  }) async {
    try {
      final request = ConnectionRequest(
        id: '',
        fromUserId: currentUserId,
        toUserId: targetUserId,
        fromUserName: currentUserProfile.name,
        fromUserProfilePictureUrl: currentUserProfile.profilePictureUrl,
        status: ConnectionRequestStatus.pending,
        createdAt: DateTime.now(),
      );
      final docRef = await _firestore
          .collection(_requestsCollection)
          .add(request.toJson());
      await docRef.update({'id': docRef.id});
    } catch (_) {
      throw const ConnectionException('Failed to create connection request.');
    }
  }

  @override
  Stream<List<ConnectionRequest>> getIncomingRequests({
    required String userId,
  }) {
    return _firestore
        .collection(_requestsCollection)
        .where('toUserId', isEqualTo: userId)
        .where('status', isEqualTo: 'pending')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => ConnectionRequest.fromJson(doc.data()))
              .toList();
        });
  }

  @override
  Future<void> acceptRequest({required ConnectionRequest request}) async {
    try {
      final callable = FirebaseFunctions.instanceFor(
        region: 'us-central1',
      ).httpsCallable('acceptRequest');
      await callable.call<void>({'requestId': request.id});
    } on FirebaseFunctionsException catch (e) {
      throw ConnectionException(
        e.message ?? 'An unknown function error occurred.',
      );
    } catch (e) {
      throw ConnectionException(e.toString());
    }
  }

  @override
  Future<void> declineRequest({required String requestId}) async {
    try {
      await _firestore.collection(_requestsCollection).doc(requestId).update({
        'status': 'declined',
      });
    } catch (_) {
      throw const ConnectionException('Failed to decline connection request.');
    }
  }

  @override
  Stream<List<Connection>> getConnections({required String userId}) {
    return _firestore
        .collection(_usersCollection)
        .doc(userId)
        .collection(_connectionsCollection)
        .orderBy('connectedAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => Connection.fromJson(doc.data()))
              .toList();
        });
  }
}
