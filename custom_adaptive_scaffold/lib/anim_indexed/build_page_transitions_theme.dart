// Copyright 2024 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.


import 'package:flutter/material.dart';



/// Code example:
///  ```
///  transitionBuilder: (child,animation,secondaryAnimation)=>
///  buildPageTransitionsTheme(context).buildTransitions(
///    ModalRoute.of(context)! as PageRoute<dynamic>,
///      context,
///      animation,
///      secondaryAnimation,
///      child,
///  ),
///   children: children,
/// ```
///
PageTransitionsTheme buildPageTransitionsTheme(BuildContext context) {
  Map<TargetPlatform, PageTransitionsBuilder> builders = Map.fromEntries(
    Theme.of(context).pageTransitionsTheme.builders.entries.map(
      (e) {
        if (e.value is ZoomPageTransitionsBuilder) {
          return MapEntry(
            e.key,
            const ZoomPageTransitionsBuilder(
              allowSnapshotting: false,
            ),
          );
        } else {
          return e;
        }
      },
    ),
  );
  if (builders[TargetPlatform.windows] == null) {
    builders[TargetPlatform.windows] = const ZoomPageTransitionsBuilder(
      allowSnapshotting: false,
    );
  }
  return PageTransitionsTheme(
    builders: builders,
  );
}