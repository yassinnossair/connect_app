// lib/src/presentation/pages/my_connections_page.dart

import 'package:flutter/material.dart' hide ConnectionState;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart'; // NEW: Import go_router
import 'package:connect/src/domain/models/connection.dart';
import 'package:connect/src/presentation/bloc/connection/connection_bloc.dart';
import 'package:connect/src/presentation/bloc/connection/connection_event.dart';
import 'package:connect/src/presentation/bloc/connection/connection_state.dart';

class MyConnectionsPage extends StatefulWidget {
  const MyConnectionsPage({super.key});

  @override
  State<MyConnectionsPage> createState() => _MyConnectionsPageState();
}

class _MyConnectionsPageState extends State<MyConnectionsPage> {
  @override
  void initState() {
    super.initState();
    context.read<ConnectionBloc>().add(ConnectionsSubscriptionRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Connections'),
      ),
      body: BlocBuilder<ConnectionBloc, ConnectionState>(
        builder: (context, state) {
          if (state.status == ConnectionStatus.loading && state.connections.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == ConnectionStatus.failure && state.connections.isEmpty) {
            return const Center(child: Text('Failed to load connections.'));
          }
          if (state.connections.isEmpty) {
            return const _NoConnectionsView();
          } else {
            return _ConnectionsListView(connections: state.connections);
          }
        },
      ),
    );
  }
}

class _NoConnectionsView extends StatelessWidget {
  const _NoConnectionsView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outline,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No Connections Yet',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Scan a QR code to start connecting.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}

class _ConnectionsListView extends StatelessWidget {
  const _ConnectionsListView({required this.connections});

  final List<Connection> connections;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: connections.length,
      itemBuilder: (context, index) {
        final connection = connections[index];
        return _ConnectionCard(connection: connection);
      },
    );
  }
}

class _ConnectionCard extends StatelessWidget {
  const _ConnectionCard({required this.connection});

  final Connection connection;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      child: ListTile(
        leading: CircleAvatar(
          radius: 28,
          backgroundImage: connection.otherUserProfilePictureUrl != null
              ? NetworkImage(connection.otherUserProfilePictureUrl!)
              : null,
          child: connection.otherUserProfilePictureUrl == null
              ? const Icon(Icons.person, size: 28)
              : null,
        ),
        title: Text(
          connection.otherUserName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(Icons.chevron_right),
        // UPDATED: This now navigates to the detail page.
        onTap: () {
          // We use context.push to navigate, passing the user's ID as an extra parameter.
          context.push(
            '/connection-detail',
            extra: {
              'userId': connection.otherUserId,
              'name': connection.otherUserName,
            },
          );
        },
      ),
    );
  }
}