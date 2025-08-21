// lib/src/data/repositories/profile_repository_impl.dart

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:connect/src/domain/models/user_profile.dart';
import 'package:connect/src/domain/repositories/profile_repository.dart';
import 'package:connect/src/data/exceptions/profile_exceptions.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl({
    FirebaseFirestore? firestore,
    firebase_storage.FirebaseStorage? firebaseStorage,
  }) : _firestore = firestore ?? FirebaseFirestore.instance,
       _firebaseStorage =
           firebaseStorage ?? firebase_storage.FirebaseStorage.instance;

  final FirebaseFirestore _firestore;
  final firebase_storage.FirebaseStorage _firebaseStorage;

  static const String _usersCollection = 'users';
  static const String _profilesSubCollection = 'profiles';

  @override
  Future<List<UserProfile>> getProfiles({required String userId}) async {
    try {
      final snapshot = await _firestore
          .collection(_usersCollection)
          .doc(userId)
          .collection(_profilesSubCollection)
          .get();

      return snapshot.docs
          .map((doc) => UserProfile.fromJson(doc.data()))
          .toList();
    } catch (_) {
      throw GetProfileFailure();
    }
  }

  @override
  Future<String> createProfile({
    required String userId,
    required UserProfile profile,
  }) async {
    try {
      final docRef = await _firestore
          .collection(_usersCollection)
          .doc(userId)
          .collection(_profilesSubCollection)
          .add(profile.toJson());

      await docRef.update({'id': docRef.id});
      return docRef.id;
    } catch (_) {
      throw UpdateProfileFailure();
    }
  }

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
          .doc(profile.id)
          .set(profile.toJson(), SetOptions(merge: true));
    } catch (_) {
      throw UpdateProfileFailure();
    }
  }

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

  @override
  Future<String> uploadProfilePicture({
    required String userId,
    required String profileId,
    required File file,
  }) async {
    try {
      final ref = _firebaseStorage.ref('profile_pictures/$userId/$profileId');
      await ref.putFile(file);
      final downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (_) {
      throw UploadProfilePictureFailure();
    }
  }
}
