// lib/src/presentation/pages/connection_handler_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:connect/src/presentation/bloc/connection/connection_bloc.dart';
import 'package:connect/src/presentation/bloc/connection/connection_event.dart';

class ConnectionHandlerPage extends StatefulWidget {
  const ConnectionHandlerPage({super.key, required this.targetUserId});

  final String targetUserId;

  @override
  State<ConnectionHandlerPage> createState() => _ConnectionHandlerPageState();
}

class _ConnectionHandlerPageState extends State<ConnectionHandlerPage> {
  @override
  void initState() {
    super.initState();
    // As soon as this page is built, we do two things:
    // 1. Add the event to the ConnectionBloc to create the request.
    context
        .read<ConnectionBloc>()
        .add(ConnectionRequestSent(targetUserId: widget.targetUserId));

    // 2. Immediately navigate the user to their home page so they don't
    //    get stuck on this temporary page. We use a post-frame callback
    //    to ensure the navigation happens after the build is complete.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.go('/');
        // Optionally, show a success message.
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text('Connection request sent!'),
              backgroundColor: Colors.green,
            ),
          );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // This page just shows a loading spinner while the request is being sent.
    // The user will only see this for a fraction of a second.
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}