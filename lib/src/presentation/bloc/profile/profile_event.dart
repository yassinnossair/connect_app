// lib/src/presentation/bloc/profile/profile_event.dart

import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class ProfileFetched extends ProfileEvent {}

class ProfileSelected extends ProfileEvent {
  const ProfileSelected(this.profileId);
  final String profileId;

  @override
  List<Object> get props => [profileId];
}

class ProfileCreated extends ProfileEvent {
  const ProfileCreated({required this.name});
  final String name;

  @override
  List<Object> get props => [name];
}

class ProfileNameChanged extends ProfileEvent {
  const ProfileNameChanged(this.name);
  final String name;

  @override
  List<Object> get props => [name];
}

class ProfileTitleChanged extends ProfileEvent {
  const ProfileTitleChanged(this.title);
  final String title;

  @override
  List<Object> get props => [title];
}

class ProfileCompanyChanged extends ProfileEvent {
  const ProfileCompanyChanged(this.company);
  final String company;

  @override
  List<Object> get props => [company];
}

class ProfilePictureChanged extends ProfileEvent {
  const ProfilePictureChanged(this.imageFile);
  final File imageFile;

  @override
  List<Object> get props => [imageFile];
}

class ProfileLinkAdded extends ProfileEvent {
  const ProfileLinkAdded(this.link);
  final Map<String, String> link;

  @override
  List<Object> get props => [link];
}

class ProfileLinkRemoved extends ProfileEvent {
  const ProfileLinkRemoved(this.link);
  final Map<String, String> link;

  @override
  List<Object> get props => [link];
}

class ProfileSaved extends ProfileEvent {}
