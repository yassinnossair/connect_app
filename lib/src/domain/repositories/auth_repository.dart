// lib/src/domain/repositories/auth_repository.dart

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

abstract class AuthRepository {
  Stream<firebase_auth.User?> get user;

  Future<void> signUp({required String email, required String password});

  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> sendPasswordResetEmail({required String email});

  Future<void> logOut();
}
