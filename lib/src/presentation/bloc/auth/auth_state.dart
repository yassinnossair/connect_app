import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

part 'auth_state.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  /// The user is authenticated.
  /// This state holds the authenticated user object.
  const factory AuthState.authenticated(firebase_auth.User user) = Authenticated;

  /// The user is not authenticated.
  /// The app will be in this state when the user is logged out or has never logged in.
  const factory AuthState.unauthenticated() = Unauthenticated;
}
