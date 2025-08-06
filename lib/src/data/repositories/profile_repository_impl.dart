// lib/src/data/repositories/profile_repository_impl.dart

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:connect/src/domain/models/user_profile.dart';
import 'package:connect/src/domain/repositories/profile_repository.dart';
import 'package:connect/src/data/repositories/profile_exceptions.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl({
    FirebaseFirestore? firestore,
    firebase_storage.FirebaseStorage? firebaseStorage,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _firebaseStorage =
            firebaseStorage ?? firebase_storage.FirebaseStorage.instance;

  final FirebaseFirestore _firestore;
  final firebase_storage.FirebaseStorage _firebaseStorage;

  static const String _usersCollection = 'users';
  static const String _profilesSubCollection = 'profiles'; // New constant

  // REFACTORED: This now gets a list of profiles from the sub-collection.
  @override
  Future<List<UserProfile>> getProfiles({required String userId}) async {
    try {
      final snapshot = await _firestore
          .collection(_usersCollection)
          .doc(userId)
          .collection(_profilesSubCollection)
          .get();

      // Map each document to a UserProfile object.
      return snapshot.docs
          .map((doc) => UserProfile.fromJson(doc.data()))
          .toList();
    } catch (_) {
      throw GetProfileFailure();
    }
  }

  // NEW: Method to create a new profile.
  @override
  Future<String> createProfile({
    required String userId,
    required UserProfile profile,
  }) async {
    try {
      // Add a new document with an auto-generated ID.
      final docRef = await _firestore
          .collection(_usersCollection)
          .doc(userId)
          .collection(_profilesSubCollection)
          .add(profile.toJson());

      // Update the new document with its own ID for easy reference.
      await docRef.update({'id': docRef.id});
      return docRef.id;
    } catch (_) {
      throw UpdateProfileFailure(); // Reusing exception for simplicity.
    }
  }

  // REFACTORED: This now updates a specific profile document.
  @override
  Future<void> updateProfile({
    required String userId,
    required UserProfile profile,
  }) async {
    try {
      await _firestore
          .collection(_usersCollection)
          .doc(userId)
          .collection(_profilesSubCollection)
          .doc(profile.id) // Use the profile's own ID to find the document.
          .set(profile.toJson(), SetOptions(merge: true));
    } catch (_) {
      throw UpdateProfileFailure();
    }
  }

  // NEW: Method to delete a profile.
  @override
  Future<void> deleteProfile({
    required String userId,
    required String profileId,
  }) async {
    try {
      await _firestore
          .collection(_usersCollection)
          .doc(userId)
          .collection(_profilesSubCollection)
          .doc(profileId)
          .delete();
    } catch (_) {
      throw UpdateProfileFailure();
    }
  }

  // REFACTORED: The upload path now includes the profileId.
  @override
  Future<String> uploadProfilePicture({
    required String userId,
    required String profileId,
    required File file,
  }) async {
    try {
      // The path is now more specific to avoid conflicts between profiles.
      final ref = _firebaseStorage.ref('profile_pictures/$userId/$profileId');
      await ref.putFile(file);
      final downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (_) {
      throw UploadProfilePictureFailure();
    }
  }
}