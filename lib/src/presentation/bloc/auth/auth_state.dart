import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

part 'auth_state.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState.authenticated(firebase_auth.User user) =
      Authenticated;

  const factory AuthState.unauthenticated() = Unauthenticated;
}
