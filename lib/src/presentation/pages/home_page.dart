// lib/src/presentation/pages/home_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:connect/src/presentation/bloc/auth/auth_bloc.dart';
import 'package:connect/src/presentation/bloc/auth/auth_event.dart';
import 'package:connect/src/presentation/bloc/auth/auth_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.select((AuthBloc bloc) {
      final state = bloc.state;
      if (state is Authenticated) {
        return state.user.email;
      }
      return null;
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Connect'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(AuthLogoutRequested());
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- Profile Section ---
            _buildSectionHeader(context, 'My Profile'),
            _buildHomeButton(
              context: context,
              icon: Icons.account_circle_outlined,
              label: 'Manage My Profiles',
              onPressed: () => context.push('/profile'),
            ),
            const SizedBox(height: 12),
            _buildHomeButton(
              context: context,
              icon: Icons.visibility_outlined, // A suitable icon for viewing
              label: 'Preview My Profile',
              onPressed: () => context.push('/view-profile'),
            ),
            const SizedBox(height: 12),
            _buildHomeButton(
              context: context,
              icon: Icons.qr_code_2_outlined,
              label: 'View My QR Code',
              onPressed: () => context.push('/my-qr'),
            ),
            const SizedBox(height: 24),

            // --- Connections Section ---
            _buildSectionHeader(context, 'My Network'),
            _buildHomeButton(
              context: context,
              icon: Icons.people_outline,
              label: 'My Connections',
              onPressed: () => context.push('/connections'),
            ),
            const SizedBox(height: 12),
            _buildHomeButton(
              context: context,
              icon: Icons.person_add_alt_1_outlined,
              label: 'Connection Requests',
              onPressed: () => context.push('/requests'),
            ),
            const Spacer(), // Pushes the scan button to the bottom
            _buildHomeButton(
              context: context,
              icon: Icons.qr_code_scanner,
              label: 'Scan to Connect',
              isPrimary: true, // Make this button stand out
              onPressed: () => context.push('/scan'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 16.0),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildHomeButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    bool isPrimary = false,
  }) {
    return ElevatedButton.icon(
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? Theme.of(context).primaryColor : null,
        foregroundColor: isPrimary ? Colors.white : null,
        padding: const EdgeInsets.symmetric(vertical: 16),
        textStyle: Theme.of(context).textTheme.titleMedium,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onPressed,
    );
  }
}
