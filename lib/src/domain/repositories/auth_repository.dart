import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

/// An abstract repository that defines the contract for all authentication-related
/// operations. This layer separates the domain logic from the data layer implementation.
abstract class AuthRepository {
  /// A stream that emits the current authenticated user.
  ///
  /// Emits a [firebase_auth.User] if a user is signed in, otherwise emits null.
  /// This is the primary way to listen for authentication state changes.
  Stream<firebase_auth.User?> get user;

  /// Signs up a new user with the given [email] and [password].
  ///
  /// Throws a [SignUpWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> signUp({required String email, required String password});

  /// Signs in a user with the given [email] and [password].
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  });



  /// Sends a password reset link to the given [email].
  ///
  /// Throws a [SendPasswordResetEmailFailure] if an exception occurs.
  Future<void> sendPasswordResetEmail({required String email});

  /// Signs out the current user.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut();
}
