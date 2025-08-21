// lib/src/domain/repositories/public_profile_repository.dart

import 'package:connect/src/domain/models/user_profile.dart';

abstract class PublicProfileRepository {
  Future<List<UserProfile>> getPublicProfiles({required String userId});
}
