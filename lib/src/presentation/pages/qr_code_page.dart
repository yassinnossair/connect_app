// lib/src/presentation/pages/qr_code_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart'; // NEW: Import qr_flutter

// NEW: Import the BLoCs and Repositories we need.
import 'package:connect/src/presentation/bloc/auth/auth_bloc.dart';
import 'package:connect/src/presentation/bloc/auth/auth_state.dart';
import 'package:connect/src/presentation/bloc/profile/profile_bloc.dart';
import 'package:connect/src/presentation/bloc/profile/profile_state.dart';

// The page is now wrapped in a BlocProvider to create the ProfileBloc.
// NEW CODE for all 3 files
class QrCodePage extends StatelessWidget {
  // Or ViewProfilePage, or QrCodePage
  const QrCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    // The BlocProvider is gone. We just return the View widget directly.
    return const QrCodeView(); // Or ViewProfileView, or QrCodeView
  }
}

class QrCodeView extends StatelessWidget {
  const QrCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My QR Code')),
      backgroundColor: Colors.grey[200],
      // We use a BlocBuilder on the AuthBloc to get the user's ID.
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          // We ensure the user is authenticated before proceeding.
          if (authState is! Authenticated) {
            // This should technically not happen due to our router rules,
            // but it's a good safeguard.
            return const Center(child: Text('Error: User not authenticated.'));
          }
          final userId = authState.user.uid;

          // We use another BlocBuilder on the ProfileBloc to get the active profile.
          return BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, profileState) {
              if (profileState.status == ProfileStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (profileState.selectedProfile == null) {
                return const Center(child: Text('No active profile found.'));
              }

              // Construct the public URL.
              // IMPORTANT: Replace 'your-project-id.web.app' with your actual
              // Firebase project ID once you deploy the web app.
              final publicUrl = 'https://connect-final-199ec.web.app/p/$userId';
              final activeProfileName = profileState.selectedProfile!.name;

              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 40.0,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Share Your Profile',
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Others can scan this code to connect.',
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(color: Colors.grey.shade600),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 32),
                          // UPDATED: This now uses the QrImageView to display the live code.
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: QrImageView(
                              data: publicUrl,
                              version: QrVersions.auto,
                              size: 250.0,
                              gapless: false, // Recommended for better scanning
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Divider(),
                          const SizedBox(height: 16),
                          // UPDATED: Displays the name of the currently active profile.
                          Text(
                            "Sharing '$activeProfileName' Profile",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
