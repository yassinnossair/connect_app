// lib/src/presentation/pages/connection_requests_page.dart

import 'package:flutter/material.dart' hide ConnectionState;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connect/src/domain/models/connection_request.dart';
import 'package:connect/src/presentation/bloc/connection/connection_bloc.dart';
import 'package:connect/src/presentation/bloc/connection/connection_event.dart';
import 'package:connect/src/presentation/bloc/connection/connection_state.dart';

class ConnectionRequestsPage extends StatefulWidget {
  const ConnectionRequestsPage({super.key});

  @override
  State<ConnectionRequestsPage> createState() => _ConnectionRequestsPageState();
}

class _ConnectionRequestsPageState extends State<ConnectionRequestsPage> {
  @override
  void initState() {
    super.initState();
    context.read<ConnectionBloc>().add(IncomingRequestsSubscriptionRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectionBloc, ConnectionState>(
      listener: (context, state) {
        if (state.status == ConnectionStatus.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  state.errorMessage ?? 'An unknown error occurred.',
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Connection Requests')),
        body: BlocBuilder<ConnectionBloc, ConnectionState>(
          builder: (context, state) {
            if (state.status == ConnectionStatus.loading &&
                state.incomingRequests.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status == ConnectionStatus.failure &&
                state.incomingRequests.isEmpty) {
              return const Center(child: Text('Failed to load requests.'));
            }
            if (state.incomingRequests.isEmpty) {
              return const _NoRequestsView();
            } else {
              return _RequestsListView(requests: state.incomingRequests);
            }
          },
        ),
      ),
    );
  }
}

class _NoRequestsView extends StatelessWidget {
  const _NoRequestsView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_add_disabled_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No New Requests',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'You have no pending connection requests.',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}

class _RequestsListView extends StatelessWidget {
  const _RequestsListView({required this.requests});

  final List<ConnectionRequest> requests;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: requests.length,
      itemBuilder: (context, index) {
        final request = requests[index];
        return _RequestCard(request: request);
      },
    );
  }
}

class _RequestCard extends StatelessWidget {
  const _RequestCard({required this.request});

  final ConnectionRequest request;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 28,
                backgroundImage: request.fromUserProfilePictureUrl != null
                    ? NetworkImage(request.fromUserProfilePictureUrl!)
                    : null,
                child: request.fromUserProfilePictureUrl == null
                    ? const Icon(Icons.person, size: 28)
                    : null,
              ),
              title: Text(
                request.fromUserName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('Wants to connect with you.'),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    context.read<ConnectionBloc>().add(
                      ConnectionRequestDeclined(requestId: request.id),
                    );
                  },
                  child: const Text('DECLINE'),
                ),
                const SizedBox(width: 8),

                ElevatedButton(
                  onPressed: () {
                    context.read<ConnectionBloc>().add(
                      ConnectionRequestAccepted(request: request),
                    );
                  },
                  child: const Text('ACCEPT'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
