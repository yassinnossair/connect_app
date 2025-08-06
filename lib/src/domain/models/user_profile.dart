// lib/src/domain/models/user_profile.dart

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    // The ID now refers to the specific profile document ID, not the user's ID.
    required String id,
    // The 'email' field has been removed as it belongs to the user, not the profile.
    required String name,
    String? title,
    String? company,
    String? profilePictureUrl,
    @Default([]) List<Map<String, String>> professionalLinks,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}