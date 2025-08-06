// lib/src/presentation/bloc/profile/profile_state.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:connect/src/domain/models/user_profile.dart';

part 'profile_state.freezed.dart';

enum ProfileStatus { initial, loading, success, failure }

@freezed
class ProfileState with _$ProfileState {
  const ProfileState._(); // Private constructor for getters

  const factory ProfileState({
    // REFACTORED: We now hold a list of all profiles.
    @Default([]) List<UserProfile> profiles,
    // NEW: We keep track of the selected profile's ID.
    String? selectedProfileId,
    // The status of the page.
    @Default(ProfileStatus.initial) ProfileStatus status,
  }) = _ProfileState;

  // NEW: A convenience getter to easily find the selected profile object.
  UserProfile? get selectedProfile {
    if (selectedProfileId == null) return null;
    try {
      return profiles.firstWhere((p) => p.id == selectedProfileId);
    } catch (_) {
      return null;
    }
  }
}