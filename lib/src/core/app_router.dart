// lib/src/core/app_router.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connect/src/domain/repositories/auth_repository.dart';
import 'package:connect/src/domain/repositories/connection_repository.dart';
import 'package:connect/src/presentation/bloc/connection/connection_bloc.dart';
import 'package:connect/src/presentation/bloc/profile/profile_bloc.dart';
import 'package:connect/src/presentation/bloc/auth/auth_bloc.dart';
import 'package:connect/src/presentation/bloc/auth/auth_state.dart';
import 'package:connect/src/presentation/pages/Connections/connection_handler_page.dart';
import 'package:connect/src/presentation/pages/Profile%20View%20and%20Managment/edit_profile_page.dart';
import 'package:connect/src/presentation/pages/Auth/forgot_password_page.dart';
import 'package:connect/src/presentation/pages/home_page.dart';
import 'package:connect/src/presentation/pages/Auth/login_page.dart';
import 'package:connect/src/presentation/pages/Auth/signup_page.dart';
import 'package:connect/src/presentation/pages/qr_code_page.dart';
import 'package:connect/src/presentation/pages/Profile%20View%20and%20Managment/view_profile_page.dart';
// NEW: Import all the new pages
import 'package:connect/src/presentation/pages/scan_page.dart';
import 'package:connect/src/presentation/pages/Connections/connection_requests_page.dart';
import 'package:connect/src/presentation/pages/Connections/my_connections_page.dart';
import 'package:connect/src/presentation/pages/Connections/connection_detail_page.dart';

class AppRouter {
  final AuthBloc authBloc;

  AppRouter(this.authBloc);

  late final GoRouter router = GoRouter(
    initialLocation: '/',
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        name: 'home',
        builder: (BuildContext context, GoRouterState state) =>
            const HomePage(),
        routes: [
          GoRoute(
            path: 'profile',
            name: 'profile',
            builder: (BuildContext context, GoRouterState state) =>
                const EditProfilePage(),
          ),
          GoRoute(
            path: 'view-profile',
            name: 'viewProfile',
            builder: (BuildContext context, GoRouterState state) =>
                const ViewProfilePage(),
          ),
          GoRoute(
            path: 'my-qr',
            name: 'myQr',
            builder: (BuildContext context, GoRouterState state) =>
                const QrCodePage(),
          ),
          // NEW: Add all the new routes as sub-routes of home.
          GoRoute(
            path: 'scan',
            name: 'scan',
            builder: (BuildContext context, GoRouterState state) =>
                const ScanPage(),
          ),
          GoRoute(
            path: 'requests',
            name: 'requests',
            builder: (BuildContext context, GoRouterState state) =>
                const ConnectionRequestsPage(),
          ),
          GoRoute(
            path: 'connections',
            name: 'connections',
            builder: (BuildContext context, GoRouterState state) =>
                const MyConnectionsPage(),
          ),
          GoRoute(
            path: 'connection-detail',
            name: 'connectionDetail',
            builder: (BuildContext context, GoRouterState state) {
              // We get the user's ID and name passed from the previous page.
              final extra = state.extra as Map<String, String>;
              return ConnectionDetailPage(
                connectionUserId: extra['userId']!,
                connectionName: extra['name']!,
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (BuildContext context, GoRouterState state) =>
            const LoginPage(),
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (BuildContext context, GoRouterState state) =>
            const SignUpPage(),
      ),
      GoRoute(
        path: '/forgot-password',
        name: 'forgot-password',
        builder: (BuildContext context, GoRouterState state) =>
            const ForgotPasswordPage(),
      ),
      GoRoute(
        path: '/p/:userId',
        name: 'scannedProfileRedirect',
        builder: (BuildContext context, GoRouterState state) {
          final userId = state.pathParameters['userId'];
          if (userId == null) {
            return const HomePage();
          }
          return BlocProvider(
            create: (context) => ConnectionBloc(
              connectionRepository: RepositoryProvider.of<ConnectionRepository>(
                context,
              ),
              profileBloc: context.read<ProfileBloc>(),
              authRepository: RepositoryProvider.of<AuthRepository>(context),
            ),
            child: ConnectionHandlerPage(targetUserId: userId),
          );
        },
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      final authState = context.read<AuthBloc>().state;
      final isAuthenticated = authState is Authenticated;

      final isGoingToAuthPage =
          state.matchedLocation == '/login' ||
          state.matchedLocation == '/signup' ||
          state.matchedLocation == '/forgot-password';

      if (isAuthenticated && isGoingToAuthPage) {
        return '/';
      }

      if (!isAuthenticated && !isGoingToAuthPage) {
        return '/login';
      }

      return null;
    },
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
