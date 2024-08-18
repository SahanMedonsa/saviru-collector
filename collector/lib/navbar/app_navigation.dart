import 'package:collector/navbar/NavigationBar.dart';
import 'package:collector/pages/Farmers.dart';
import 'package:collector/pages/distributor.dart';
import 'package:collector/pages/farmerinquiry.dart';
import 'package:collector/pages/hervestcollection.dart';
import 'package:collector/pages/updateinquiry.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class AppNavigation {
  AppNavigation._();

  static String initRoute = '/home';

  static final GlobalKey<NavigatorState> _rootNavigationKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> _rootNavigationHome =
      GlobalKey<NavigatorState>(debugLabel: 'shellHome');

  static final GlobalKey<NavigatorState> _rootNavigationVegestat =
      GlobalKey<NavigatorState>(debugLabel: 'shellvege');

  static final GlobalKey<NavigatorState> _rootNavigationBlog =
      GlobalKey<NavigatorState>(debugLabel: 'shellinfor');

  static final GlobalKey<NavigatorState> _rootNavigationlogin =
      GlobalKey<NavigatorState>(debugLabel: 'shelllogin');

  static final GoRouter router = GoRouter(
    initialLocation: initRoute,
    navigatorKey: _rootNavigationKey,
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return CustomBottomNavigationBar(
            navigationShell: navigationShell,
          );
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(navigatorKey: _rootNavigationHome, routes: [
            GoRoute(
              path: '/home',
              name: 'Home',
              builder: (context, state) {
                return Collection(
                  key: state.pageKey,
                );
              },
              routes: [
                GoRoute(
                  path: 'farmer/:id/:name',
                  name: 'farmer',
                  builder: (context, state) {
                    final id = state.pathParameters['id']!;
                    final name = state.pathParameters['name']!;
                    return Farmers(
                      key: state.pageKey,
                      farmerId: id,
                      farmerName: name,
                    );
                  },
                ),
              ],
            ),
          ]),
          StatefulShellBranch(navigatorKey: _rootNavigationVegestat, routes: [
            GoRoute(
              path: '/vegestatus',
              name: 'Vegestatus',
              builder: (context, state) {
                return farmereInquiry(
                  key: state.pageKey,
                );
              },
              routes: [
                GoRoute(
                  path: 'farmerinquiry',
                  name: 'farmerinquiry',
                  builder: (context, state) {
                    return UpdateInquiry(
                      key: state.pageKey,
                    );
                  },
                ),
              ],
            ),
          ]),
          StatefulShellBranch(navigatorKey: _rootNavigationBlog, routes: [
            GoRoute(
              path: '/info',
              name: 'Info',
              builder: (context, state) {
                return distrubutor(
                  key: state.pageKey,
                );
              },
            ),
          ]),
        ],
      ),
    ],
  );
}
