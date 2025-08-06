// lib/src/domain/repositories/profile_repository.dart

import 'dart:io';
import 'package:connect/src/domain/models/user_profile.dart';

abstract class ProfileRepository {
  /// Fetches a list of all [UserProfile]s for the given [userId].
  Future<List<UserProfile>> getProfiles({required String userId});

  /// Creates a new profile document for the given [userId] and returns its new ID.
  Future<String> createProfile({
    required String userId,
    required UserProfile profile,
  });

  /// Updates a specific profile document. The profile's ID is used to find it.
  Future<void> updateProfile({
    required String userId,
    required UserProfile profile,
  });

  /// Deletes a specific profile document by its [profileId].
  Future<void> deleteProfile({
    required String userId,
    required String profileId,
  });

  /// Uploads a profile picture for a specific profile and returns the URL.
  Future<String> uploadProfilePicture({
    required String userId,
    required String profileId,
    required File file,
  });
}