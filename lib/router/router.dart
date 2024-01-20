// The route configuration.
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:riddle_me/presentation/home_screen/home_screen.dart';
import 'package:riddle_me/presentation/intital_screens/welcome_screen.dart';

import '../logic/config_bloc/config_bloc.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          if (context.read<ConfigBloc>().state.hasSeenInitialScreen) {
            return const HomeScreen();
          }
          return const WelcomeScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'welcome_screen',
            builder: (BuildContext context, GoRouterState state) {
              return const WelcomeScreen();
            },
          ),
          GoRoute(
            path: 'home',
            builder: (BuildContext context, GoRouterState state) {
              return const HomeScreen();
            },
          ),
        ],
      ),
    ],
  );
}
