// lib/src/domain/repositories/profile_repository.dart

import 'dart:io';
import 'package:connect/src/domain/models/user_profile.dart';

abstract class ProfileRepository {
  Future<List<UserProfile>> getProfiles({required String userId});

  Future<String> createProfile({
    required String userId,
    required UserProfile profile,
  });

  Future<void> updateProfile({
    required String userId,
    required UserProfile profile,
  });

  Future<void> deleteProfile({
    required String userId,
    required String profileId,
  });

  Future<String> uploadProfilePicture({
    required String userId,
    required String profileId,
    required File file,
  });
}
