// lib/src/app.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connect/src/core/app_router.dart';
import 'package:connect/src/data/repositories/auth_repository_impl.dart';
import 'package:connect/src/data/repositories/connection_repository_impl.dart';
import 'package:connect/src/data/repositories/profile_repository_impl.dart';
import 'package:connect/src/data/repositories/public_profile_repository_impl.dart';
import 'package:connect/src/domain/repositories/auth_repository.dart';
import 'package:connect/src/domain/repositories/connection_repository.dart';
import 'package:connect/src/domain/repositories/profile_repository.dart';
import 'package:connect/src/domain/repositories/public_profile_repository.dart';
import 'package:connect/src/presentation/bloc/auth/auth_bloc.dart';
import 'package:connect/src/presentation/bloc/auth/auth_state.dart';
import 'package:connect/src/presentation/bloc/profile/profile_bloc.dart';
import 'package:connect/src/presentation/bloc/profile/profile_event.dart';
import 'package:connect/src/presentation/bloc/connection/connection_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepositoryImpl(),
        ),
        // Define ProfileRepository first...
        RepositoryProvider<ProfileRepository>(
          create: (context) => ProfileRepositoryImpl(),
        ),
        // ...then define ConnectionRepository, which depends on it.
        RepositoryProvider<ConnectionRepository>(
          create: (context) => ConnectionRepositoryImpl(),
        ),
        RepositoryProvider<PublicProfileRepository>(
          create: (context) => PublicProfileRepositoryImpl(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: RepositoryProvider.of<AuthRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => ProfileBloc(
              authRepository: RepositoryProvider.of<AuthRepository>(context),
              profileRepository: RepositoryProvider.of<ProfileRepository>(
                context,
              ),
            ),
          ),
          BlocProvider(
            create: (context) => ConnectionBloc(
              connectionRepository: RepositoryProvider.of<ConnectionRepository>(
                context,
              ),
              profileBloc: context.read<ProfileBloc>(),
              // UPDATED: Add the missing required argument.
              authRepository: RepositoryProvider.of<AuthRepository>(context),
            ),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          context.read<ProfileBloc>().add(ProfileFetched());
        }
      },
      child: MaterialApp.router(
        title: 'ConnectSphere',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routerConfig: AppRouter(context.read<AuthBloc>()).router,
      ),
    );
  }
}
