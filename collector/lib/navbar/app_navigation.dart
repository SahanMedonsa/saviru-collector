import 'package:collector/navbar/NavigationBar.dart';
import 'package:collector/pages/distributor.dart';
import 'package:collector/pages/farmerinquiry.dart';
import 'package:collector/pages/hervestcollection.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class AppNavigation {
  AppNavigation._();

  static String initRoute = '/home';

  // Private navigation key
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

  // Define the routes for GoRouter
  static final GoRouter router = GoRouter(
    initialLocation: initRoute,
    navigatorKey: _rootNavigationKey,
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      //Main navbar
      StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return CustomBottomNavigationBar(
              navigationShell: navigationShell,
            );
          },
          branches: <StatefulShellBranch>[
            //Home
            StatefulShellBranch(navigatorKey: _rootNavigationHome, routes: [
              GoRoute(
                path: '/home',
                name: 'Home',
                builder: (context, state) {
                  return Collection(
                    key: state.pageKey,
                  );
                },
              )
            ]),

            //vege stat
            StatefulShellBranch(navigatorKey: _rootNavigationVegestat, routes: [
              GoRoute(
                path: '/vegestatus',
                name: 'Vegestatus',
                builder: (context, state) {
                  return farmereInquiry(
                    key: state.pageKey,
                  );
                },
              )
            ]),

            // // distributor
            StatefulShellBranch(navigatorKey: _rootNavigationBlog, routes: [
              GoRoute(
                path: '/info',
                name: 'Info',
                builder: (context, state) {
                  return distrubutor(
                    key: state.pageKey,
                  );
                },
              )
            ]),
          ]),

      // //Login
      // StatefulShellBranch(navigatorKey: _rootNavigationlogin, routes: [
      //   GoRoute(
      //       path: '/login',
      //       name: 'Login',
      //       builder: (context, state) {
      //         return LoginPage(
      //           key: state.pageKey,
      //         );
      //       },
      //       //profileview
      //       routes: [
      //         GoRoute(
      //           path: 'Profile',
      //           name: 'Profile',
      //           builder: (context, state) {
      //             return Profilescreen(
      //               key: state.pageKey,
      //             );
      //           },
      //         )
      //       ]
      // ),
      // ])
      // ],
      //)
    ],
  );
}
