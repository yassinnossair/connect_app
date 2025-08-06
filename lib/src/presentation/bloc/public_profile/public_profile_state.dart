// lib/src/presentation/bloc/public_profile/public_profile_state.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:connect/src/domain/models/user_profile.dart';

part 'public_profile_state.freezed.dart';

enum PublicProfileStatus { initial, loading, success, failure }

@freezed
class PublicProfileState with _$PublicProfileState {
  const factory PublicProfileState({
    @Default(PublicProfileStatus.initial) PublicProfileStatus status,
    @Default([]) List<UserProfile> profiles,
  }) = _PublicProfileState;
}