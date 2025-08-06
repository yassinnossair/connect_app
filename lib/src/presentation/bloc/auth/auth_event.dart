import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

/// The base class for all authentication-related events.
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Event fired when the authentication state changes (e.g., user logs in/out).
/// This is intended for internal use by the BLoC when it listens to the
/// user stream from the repository.
class AuthUserChanged extends AuthEvent {
  const AuthUserChanged(this.user);

  final firebase_auth.User? user;

  @override
  List<Object?> get props => [user];
}

/// Event fired when the user explicitly requests to log out.
class AuthLogoutRequested extends AuthEvent {}
