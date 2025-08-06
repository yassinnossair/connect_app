import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:connect/firebase_options.dart';
import 'package:connect/src/app.dart';

/// The main entry point for the application.
Future<void> main() async {
  // Ensure that the Flutter binding is initialized before calling native code.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with the platform-specific options.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Run the root widget of the application.
  runApp(const App());
}