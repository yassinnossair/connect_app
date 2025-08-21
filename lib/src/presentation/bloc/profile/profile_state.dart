// lib/src/presentation/bloc/profile/profile_state.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:connect/src/domain/models/user_profile.dart';

part 'profile_state.freezed.dart';

enum ProfileStatus { initial, loading, success, failure }

@freezed
class ProfileState with _$ProfileState {
  const ProfileState._();

  const factory ProfileState({
    @Default([]) List<UserProfile> profiles,

    String? selectedProfileId,

    @Default(ProfileStatus.initial) ProfileStatus status,
  }) = _ProfileState;

  UserProfile? get selectedProfile {
    if (selectedProfileId == null) return null;
    try {
      return profiles.firstWhere((p) => p.id == selectedProfileId);
    } catch (_) {
      return null;
    }
  }
}
