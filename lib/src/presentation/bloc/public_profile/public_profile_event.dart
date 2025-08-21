// lib/src/presentation/bloc/public_profile/public_profile_event.dart

import 'package:equatable/equatable.dart';

abstract class PublicProfileEvent extends Equatable {
  const PublicProfileEvent();

  @override
  List<Object> get props => [];
}

class PublicProfileFetched extends PublicProfileEvent {
  const PublicProfileFetched({required this.userId});
  final String userId;

  @override
  List<Object> get props => [userId];
}
