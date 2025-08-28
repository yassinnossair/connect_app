// lib/src/presentation/pages/view_profile_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:connect/src/presentation/bloc/profile/profile_bloc.dart';
import 'package:connect/src/presentation/bloc/profile/profile_state.dart';

class ViewProfilePage extends StatelessWidget {
  const ViewProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ViewProfileView();
  }
}

class ViewProfileView extends StatelessWidget {
  const ViewProfileView({super.key});

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      debugPrint('Could not launch $urlString');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile Preview')),
      backgroundColor: Colors.grey[100],
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state.selectedProfile == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final profile = state.selectedProfile!;

          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                vertical: 24.0,
                horizontal: 16.0,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundImage: profile.profilePictureUrl != null
                              ? NetworkImage(profile.profilePictureUrl!)
                              : null,
                          child: profile.profilePictureUrl == null
                              ? const Icon(Icons.person, size: 70)
                              : null,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          profile.name,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        if (profile.title != null && profile.title!.isNotEmpty)
                          Text(
                            profile.title!,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        const SizedBox(height: 4),
                        if (profile.company != null &&
                            profile.company!.isNotEmpty)
                          Text(
                            profile.company!,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        const SizedBox(height: 24),
                        if (profile.professionalLinks.isNotEmpty) ...[
                          const Divider(),
                          const SizedBox(height: 16),
                          Text(
                            'Connect',
                            style: Theme.of(context).textTheme.titleMedium,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 12.0,
                            runSpacing: 8.0,
                            children: profile.professionalLinks.map((link) {
                              return ElevatedButton(
                                onPressed: () {
                                  if (link['url'] != null) {
                                    _launchUrl(link['url']!);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                ),
                                child: Text(link['type'] ?? 'Link'),
                              );
                            }).toList(),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
