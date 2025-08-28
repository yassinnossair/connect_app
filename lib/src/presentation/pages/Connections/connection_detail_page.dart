// lib/src/presentation/pages/connection_detail_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:connect/src/domain/models/user_profile.dart';
import 'package:connect/src/domain/repositories/public_profile_repository.dart';

class ConnectionDetailCubit extends Cubit<List<UserProfile>?> {
  ConnectionDetailCubit(this._publicProfileRepository) : super(null);

  final PublicProfileRepository _publicProfileRepository;

  Future<void> fetchConnectionProfiles(String userId) async {
    try {
      final profiles = await _publicProfileRepository.getPublicProfiles(
        userId: userId,
      );
      emit(profiles);
    } catch (_) {
      emit([]);
    }
  }
}

class ConnectionDetailPage extends StatelessWidget {
  const ConnectionDetailPage({
    super.key,
    required this.connectionName,
    required this.connectionUserId,
  });

  final String connectionName;
  final String connectionUserId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConnectionDetailCubit(
        RepositoryProvider.of<PublicProfileRepository>(context),
      )..fetchConnectionProfiles(connectionUserId),
      child: ConnectionDetailView(connectionName: connectionName),
    );
  }
}

class ConnectionDetailView extends StatelessWidget {
  const ConnectionDetailView({super.key, required this.connectionName});
  final String connectionName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(connectionName)),
      body: BlocBuilder<ConnectionDetailCubit, List<UserProfile>?>(
        builder: (context, profiles) {
          if (profiles == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (profiles.isEmpty) {
            return const Center(
              child: Text('This user has not set up any profiles.'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: profiles.length,
            itemBuilder: (context, index) {
              return _ProfileCard(profile: profiles[index]);
            },
          );
        },
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({required this.profile});

  final UserProfile profile;

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      debugPrint('Could not launch $urlString');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: profile.profilePictureUrl != null
                  ? NetworkImage(profile.profilePictureUrl!)
                  : null,
              child: profile.profilePictureUrl == null
                  ? const Icon(Icons.person, size: 50)
                  : null,
            ),
            const SizedBox(height: 16),
            Text(
              profile.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            if (profile.title != null && profile.title!.isNotEmpty)
              Text(
                profile.title!,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 4),
            if (profile.company != null && profile.company!.isNotEmpty)
              Text(
                profile.company!,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            if (profile.professionalLinks.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 8),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8.0,
                runSpacing: 4.0,
                children: profile.professionalLinks.map((link) {
                  return ElevatedButton(
                    onPressed: () {
                      if (link['url'] != null) {
                        _launchUrl(link['url']!);
                      }
                    },
                    child: Text(link['type'] ?? 'Link'),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
