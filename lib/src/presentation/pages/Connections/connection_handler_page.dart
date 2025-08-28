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

    context.read<ConnectionBloc>().add(
      ConnectionRequestSent(targetUserId: widget.targetUserId),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.go('/');

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
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
