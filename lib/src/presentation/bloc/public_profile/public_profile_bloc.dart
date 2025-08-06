// lib/src/presentation/bloc/public_profile/public_profile_bloc.dart

import 'package:bloc/bloc.dart';
import 'package:connect/src/domain/repositories/public_profile_repository.dart';
import 'package:connect/src/presentation/bloc/public_profile/public_profile_event.dart';
import 'package:connect/src/presentation/bloc/public_profile/public_profile_state.dart';

class PublicProfileBloc extends Bloc<PublicProfileEvent, PublicProfileState> {
  PublicProfileBloc({required PublicProfileRepository publicProfileRepository})
      : _publicProfileRepository = publicProfileRepository,
        super(const PublicProfileState()) {
    on<PublicProfileFetched>(_onPublicProfileFetched);
  }

  final PublicProfileRepository _publicProfileRepository;

  Future<void> _onPublicProfileFetched(
      PublicProfileFetched event,
      Emitter<PublicProfileState> emit,
      ) async {
    emit(state.copyWith(status: PublicProfileStatus.loading));
    try {
      final profiles = await _publicProfileRepository.getPublicProfiles(
        userId: event.userId,
      );
      emit(state.copyWith(
        status: PublicProfileStatus.success,
        profiles: profiles,
      ));
    } catch (_) {
      emit(state.copyWith(status: PublicProfileStatus.failure));
    }
  }
}