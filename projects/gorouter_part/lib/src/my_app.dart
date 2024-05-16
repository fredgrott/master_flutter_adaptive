// Copyright 2024 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:go_transitions/go_transitions.dart';
import 'package:gorouter_part/src/custom_scroll_behavior.dart';
import 'package:gorouter_part/src/global_context.dart';
import 'package:gorouter_part/src/layout_utils.dart';
import 'package:gorouter_part/src/nav_observer.dart';
import 'package:gorouter_part/src/sample_feature/sample_item_details_view.dart';
import 'package:gorouter_part/src/sample_feature/sample_item_list_view.dart';

import 'package:gorouter_part/src/scaffold_with_nav_bar.dart';
import 'package:gorouter_part/src/settings/settings_controller.dart';
import 'package:gorouter_part/src/settings/settings_view.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _tabANavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'tabANav');
final GlobalKey<NavigatorState> _tabBNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'tabBNav');

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  // do not implement routerConfig as a function
  // but instead inline it.

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: settingsController,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp.router(
            // turn off debug banner
            debugShowCheckedModeBanner: false,
            // gorouter set up
            routerConfig: GoRouter(
              // for debugging gorouter routes
              observers: <NavigatorObserver>[NavObserver()],
              navigatorKey: _rootNavigatorKey,
              initialLocation: '/home',
              routes: <RouteBase>[
                StatefulShellRoute(
                  builder: (BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
                    // This nested StatefulShellRoute demonstrates the use of a
                    // custom container for the branch Navigators. In this implementation,
                    // no customization is done in the builder function (navigationShell
                    // itself is simply used as the Widget for the route). Instead, the
                    // navigatorContainerBuilder function below is provided to
                    // customize the container for the branch Navigators.
                    return navigationShell;
                  },
                  navigatorContainerBuilder:
                      (BuildContext context, StatefulNavigationShell navigationShell, List<Widget> children) {
                    // Returning a customized container for the branch
                    // Navigators (i.e. the `List<Widget> children` argument).
                    //
                    // See ScaffoldWithNavBar for more details on how the children
                    // are managed (using AnimatedBranchContainer).
                    return ScaffoldWithNavBar(navigationShell: navigationShell, children: children);
                  },
                  branches: <StatefulShellBranch>[
                    StatefulShellBranch(navigatorKey: _tabANavigatorKey, routes: <RouteBase>[
                      GoRoute(
                        path: '/home',
                        builder: (BuildContext context, GoRouterState state) =>
                            SettingsView(controller: settingsController),
                      )
                    ]),
                    StatefulShellBranch(navigatorKey: _tabBNavigatorKey, routes: <RouteBase>[
                      GoRoute(
                          path: '/list',
                          builder: (BuildContext context, GoRouterState state) => const SampleItemListView(),
                          routes: <RouteBase>[
                            // The details screen to display stacked on navigator of the
                            // first tab. This will cover screen A but not the application
                            // shell (bottom navigation bar).
                            GoRoute(
                              path: 'details',
                              builder: (BuildContext context, GoRouterState state) => const SampleItemDetailsView(),
                            ),
                          ])
                    ])
                  ],
                )
              ],

              // redirect: 
              //  is for both the guard such as login and
              // any onboarding for new users.
            ),
            // so we have global context
            // for localization calls outside
            // of widgets
            scaffoldMessengerKey: scaffoldMessengerKey,
            // specify scroll behavior
            scrollBehavior: CustomScrollBehavior(),
            restorationScopeId: 'app',
            theme: ThemeData(
              brightness: Brightness.light,
              // set visualdensity via
              // breakpoints
              visualDensity: LayoutUtils.getVisualDensity(context),
              // page animations
              pageTransitionsTheme: const PageTransitionsTheme(
                builders: {
                  TargetPlatform.android: GoTransitions.fadeUpwards,
                  TargetPlatform.iOS: GoTransitions.cupertino,
                  TargetPlatform.macOS: GoTransitions.cupertino,
                  TargetPlatform.windows: GoTransitions.fadeUpwards,
                  TargetPlatform.linux: GoTransitions.fadeUpwards,
                },
              ),
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              visualDensity: LayoutUtils.getVisualDensity(context),
              pageTransitionsTheme: const PageTransitionsTheme(
                builders: {
                  TargetPlatform.android: GoTransitions.fadeUpwards,
                  TargetPlatform.iOS: GoTransitions.cupertino,
                  TargetPlatform.macOS: GoTransitions.cupertino,
                  TargetPlatform.windows: GoTransitions.fadeUpwards,
                  TargetPlatform.linux: GoTransitions.fadeUpwards,
                },
              ),
            ),
            themeMode: settingsController.themeMode,
            // Provide the generated AppLocalizations to the MaterialApp. This
            // allows descendant Widgets to display the correct translations
            // depending on the user's locale.
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''), // English, no country code
            ],

            // Use AppLocalizations to configure the correct application title
            // depending on the user's locale.
            //
            // The appTitle is defined in .arb files found in the localization
            // directory.
            onGenerateTitle: (BuildContext context) => AppLocalizations.of(context)!.appTitle,
          );
        });
  }
}
