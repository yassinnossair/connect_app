import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:connect/src/domain/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

/// A BLoC that manages the authentication state of the application.
///
/// It listens to authentication state changes from the [AuthRepository]
/// and emits [AuthState]s accordingly.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  /// The constructor requires an [AuthRepository] to interact with the
  /// authentication backend.
  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
  // The initial state is unauthenticated until the stream provides an update.
        super(const AuthState.unauthenticated()) {
    // Register the event handlers
    on<AuthUserChanged>(_onUserChanged);
    on<AuthLogoutRequested>(_onLogoutRequested);

    // Subscribe to the user stream from the repository.
    // The BLoC will receive a new user object (or null) whenever the auth state changes.
    _userSubscription = _authRepository.user.listen(
          (user) => add(AuthUserChanged(user)),
    );
  }

  final AuthRepository _authRepository;
  late final StreamSubscription<firebase_auth.User?> _userSubscription;

  /// Handles the [AuthUserChanged] event.
  ///
  /// This event is triggered by the user stream. It checks if the user
  /// is null or not and emits the corresponding state.
  void _onUserChanged(AuthUserChanged event, Emitter<AuthState> emit) {
    if (event.user != null) {
      // If the user is not null, emit the authenticated state with the user object.
      emit(AuthState.authenticated(event.user!));
    } else {
      // If the user is null, emit the unauthenticated state.
      emit(const AuthState.unauthenticated());
    }
  }

  /// Handles the [AuthLogoutRequested] event.
  ///
  /// This event is triggered by the UI when the user taps a 'Logout' button.
  void _onLogoutRequested(
      AuthLogoutRequested event,
      Emitter<AuthState> emit,
      ) {
    // We don't need to emit a state here. We just tell the repository to log out.
    // The user stream will automatically fire a new null user, which will be
    // caught by our listener, triggering an `AuthUserChanged` event, which in
    // turn will emit the `Unauthenticated` state. This keeps the logic clean.
    unawaited(_authRepository.logOut());
  }

  /// It's crucial to cancel the stream subscription when the BLoC is closed
  /// to prevent memory leaks.
  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}