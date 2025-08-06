// lib/src/presentation/bloc/profile/profile_bloc.dart

import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:connect/src/domain/models/user_profile.dart';
import 'package:connect/src/domain/repositories/auth_repository.dart';
import 'package:connect/src/domain/repositories/profile_repository.dart';
import 'package:connect/src/presentation/bloc/profile/profile_event.dart';
import 'package:connect/src/presentation/bloc/profile/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required AuthRepository authRepository,
    required ProfileRepository profileRepository,
  })  : _authRepository = authRepository,
        _profileRepository = profileRepository,
        super(const ProfileState()) {
    on<ProfileFetched>(_onProfileFetched);
    on<ProfileSelected>(_onProfileSelected);
    on<ProfileCreated>(_onProfileCreated);
    on<ProfileNameChanged>(_onProfileNameChanged);
    on<ProfileTitleChanged>(_onProfileTitleChanged);
    on<ProfileCompanyChanged>(_onProfileCompanyChanged);
    on<ProfilePictureChanged>(_onProfilePictureChanged);
    on<ProfileLinkAdded>(_onProfileLinkAdded);
    on<ProfileLinkRemoved>(_onProfileLinkRemoved);
    on<ProfileSaved>(_onProfileSaved);
  }

  final AuthRepository _authRepository;
  final ProfileRepository _profileRepository;

  Future<void> _onProfileFetched(
      ProfileFetched event,
      Emitter<ProfileState> emit,
      ) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      final user = await _authRepository.user.first;
      if (user == null) throw Exception('User not found');

      var profiles = await _profileRepository.getProfiles(userId: user.uid);

      // If the user has no profiles (e.g., first-time login), create a default one.
      if (profiles.isEmpty) {
        await _profileRepository.createProfile(
          userId: user.uid,
          profile: const UserProfile(id: '', name: 'Work'), // 'id' will be set by repo
        );
        // Re-fetch the profiles list which will now contain the new default profile.
        profiles = await _profileRepository.getProfiles(userId: user.uid);
      }

      emit(state.copyWith(
        status: ProfileStatus.success,
        profiles: profiles,
        // Select the first profile by default.
        selectedProfileId: profiles.isNotEmpty ? profiles.first.id : null,
      ));
    } catch (_) {
      emit(state.copyWith(status: ProfileStatus.failure));
    }
  }

  void _onProfileSelected(ProfileSelected event, Emitter<ProfileState> emit) {
    emit(state.copyWith(selectedProfileId: event.profileId));
  }

  Future<void> _onProfileCreated(ProfileCreated event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      final user = await _authRepository.user.first;
      if (user == null) throw Exception('User not found');

      final newProfileId = await _profileRepository.createProfile(
        userId: user.uid,
        profile: UserProfile(id: '', name: event.name),
      );

      final profiles = await _profileRepository.getProfiles(userId: user.uid);

      emit(state.copyWith(
        status: ProfileStatus.success,
        profiles: profiles,
        selectedProfileId: newProfileId, // Select the newly created profile.
      ));

    } catch(_) {
      emit(state.copyWith(status: ProfileStatus.failure));
    }
  }

  void _onProfileNameChanged(ProfileNameChanged event, Emitter<ProfileState> emit) {
    if (state.selectedProfile == null) return;

    final updatedProfile = state.selectedProfile!.copyWith(name: event.name);
    _updateProfileInState(updatedProfile, emit);
  }

  void _onProfileTitleChanged(ProfileTitleChanged event, Emitter<ProfileState> emit) {
    if (state.selectedProfile == null) return;

    final updatedProfile = state.selectedProfile!.copyWith(title: event.title);
    _updateProfileInState(updatedProfile, emit);
  }

  void _onProfileCompanyChanged(ProfileCompanyChanged event, Emitter<ProfileState> emit) {
    if (state.selectedProfile == null) return;

    final updatedProfile = state.selectedProfile!.copyWith(company: event.company);
    _updateProfileInState(updatedProfile, emit);
  }

  void _onProfileLinkAdded(ProfileLinkAdded event, Emitter<ProfileState> emit) {
    if (state.selectedProfile == null) return;
    final updatedLinks = List<Map<String, String>>.from(state.selectedProfile!.professionalLinks)..add(event.link);
    final updatedProfile = state.selectedProfile!.copyWith(professionalLinks: updatedLinks);
    _updateProfileInState(updatedProfile, emit);
  }

  void _onProfileLinkRemoved(ProfileLinkRemoved event, Emitter<ProfileState> emit) {
    if (state.selectedProfile == null) return;
    final updatedLinks = List<Map<String, String>>.from(state.selectedProfile!.professionalLinks)..remove(event.link);
    final updatedProfile = state.selectedProfile!.copyWith(professionalLinks: updatedLinks);
    _updateProfileInState(updatedProfile, emit);
  }

  Future<void> _onProfilePictureChanged(
      ProfilePictureChanged event,
      Emitter<ProfileState> emit,
      ) async {
    if (state.selectedProfile == null) return;
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      final user = await _authRepository.user.first;
      if (user == null) throw Exception('User not found');

      final downloadUrl = await _profileRepository.uploadProfilePicture(
        userId: user.uid,
        profileId: state.selectedProfileId!,
        file: event.imageFile,
      );

      final updatedProfile = state.selectedProfile!.copyWith(profilePictureUrl: downloadUrl);
      _updateProfileInState(updatedProfile, emit);

      // Also save the change immediately to the database.
      await _profileRepository.updateProfile(userId: user.uid, profile: updatedProfile);

      emit(state.copyWith(status: ProfileStatus.success));
    } catch (_) {
      emit(state.copyWith(status: ProfileStatus.failure));
    }
  }

  Future<void> _onProfileSaved(ProfileSaved event, Emitter<ProfileState> emit) async {
    if (state.selectedProfile == null) return;
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      final user = await _authRepository.user.first;
      if (user == null) throw Exception('User not found');

      await _profileRepository.updateProfile(userId: user.uid, profile: state.selectedProfile!);
      emit(state.copyWith(status: ProfileStatus.success));
    } catch (_) {
      emit(state.copyWith(status: ProfileStatus.failure));
    }
  }

  // Helper method to update a profile object within the state's list.
  void _updateProfileInState(UserProfile updatedProfile, Emitter<ProfileState> emit) {
    final newProfilesList = state.profiles.map((p) {
      return p.id == updatedProfile.id ? updatedProfile : p;
    }).toList();

    emit(state.copyWith(profiles: newProfilesList));
  }
}