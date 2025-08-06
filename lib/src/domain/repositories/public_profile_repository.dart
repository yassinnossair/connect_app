// lib/src/domain/repositories/public_profile_repository.dart

import 'package:connect/src/domain/models/user_profile.dart';

/// A repository specifically for fetching profile data for the public web page.
/// This does not require an authenticated user.
abstract class PublicProfileRepository {
  /// Fetches a list of all [UserProfile]s for a given [userId].
  Future<List<UserProfile>> getPublicProfiles({required String userId});
}