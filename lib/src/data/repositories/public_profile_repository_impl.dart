// lib/src/data/repositories/public_profile_repository_impl.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect/src/domain/models/user_profile.dart';
import 'package:connect/src/domain/repositories/public_profile_repository.dart';

class PublicProfileRepositoryImpl implements PublicProfileRepository {
  PublicProfileRepositoryImpl({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  static const String _usersCollection = 'users';
  static const String _profilesSubCollection = 'profiles';

  @override
  Future<List<UserProfile>> getPublicProfiles({required String userId}) async {
    try {
      final snapshot = await _firestore
          .collection(_usersCollection)
          .doc(userId)
          .collection(_profilesSubCollection)
          .get();

      if (snapshot.docs.isEmpty) {
        return [];
      }

      return snapshot.docs
          .map((doc) => UserProfile.fromJson(doc.data()))
          .toList();
    } catch (_) {
      throw Exception('Could not fetch user profiles.');
    }
  }
}
