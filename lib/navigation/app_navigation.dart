import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nested_navigation/views/home/home_view.dart';
import 'package:nested_navigation/views/home/sub_home_view.dart';
import 'package:nested_navigation/views/player/player_view.dart';
import 'package:nested_navigation/views/settings/setting_view.dart';
import 'package:nested_navigation/views/settings/sub_setting_view.dart';
import 'package:nested_navigation/views/wrapper/main_wrapper.dart';

class AppNavigation {
  AppNavigation._();

  static String initR = '/home';

  /// Private Navigation Keys
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _rootNavigatorHome =
      GlobalKey<NavigatorState>(debugLabel: 'shellHome');
  static final _rootNavigatorSetting =
      GlobalKey<NavigatorState>(debugLabel: 'shellSetting');

  // Go Router Configuration
  static final GoRouter router = GoRouter(
    initialLocation: initR,
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      /// MainWrapper Route
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainWrapper(
            navigationShell: navigationShell,
          );
        },
        branches: <StatefulShellBranch>[
          /// Branch Home
          StatefulShellBranch(
            navigatorKey: _rootNavigatorHome,
            routes: [
              GoRoute(
                path: '/home',
                name: 'Home',
                builder: (context, state) {
                  return HomeView(
                    key: state.pageKey,
                  );
                },
                routes: [
                  /// Sub Home View
                  GoRoute(
                    path: 'subHome',
                    name: 'subHome',
                    builder: (context, state) {
                      return SubHomeView(
                        key: state.pageKey,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),

          /// Branch Settings
          StatefulShellBranch(navigatorKey: _rootNavigatorSetting, routes: [
            GoRoute(
              path: '/setting',
              name: 'Setting',
              builder: (context, state) {
                return SettingsView(
                  key: state.pageKey,
                );
              },
              routes: [
                /// Sub Settings View
                GoRoute(
                  path: 'subSetting',
                  name: 'subSetting',
                  builder: (context, state) {
                    return SubSettingsView(
                      key: state.pageKey,
                    );
                  },
                ),
              ],
            )
          ])
        ],
      ),

      // Player Route
      GoRoute(
        path: '/player',
        name: 'Player',
        builder: (context, state) {
          return PlayerView(
            key: state.pageKey,
          );
        },
      ),
    ],
  );
}
