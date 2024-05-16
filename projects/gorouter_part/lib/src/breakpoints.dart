// Copyright 2024 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

// Note: Generally when we implement models required in
//       implementing the adaptive scaffold and canonical
//       layout patterns we do not stick models or entities
//       in the domain layer but keep them together with
//       the view-model like logic in one file.
//
//       This practice is borrowed from the Google Flutter and
//       Dart teams as its the practice they use when creating
//       the codelabs examples. As well as the two top IO
//       presenters such as GSKinner and VeryGoodVentures also
//       use the same practice.

/// [Breakpoints], [WindowSizeEnum], and [LayoutUtils] form
/// the core of my approach to implementing the paired 
/// Adaptive Scaffold and Canonical Layouts pattern to 
/// handle devices of all sizes and form factors including 
/// foldables.
///
/// So let me explain why. Under Material Design 2 we 
/// had the adaptive navigation package which employed 
/// material design 2 breakpoints and navigation types 
/// of bottom, rail, drawer, and permanent drawer. It's
/// draw backs were not handling animation properly and 
/// no support of MD3 breakpoints (window sizes) or the 
/// improved adaptive scaffold patterns or foldables.
///
/// Microsoft came up with support of surface foldables 
/// via the Android native package twopanelayout for 
/// jet compose and a flutter based two pane layout as 
/// part of the flutter dual screen package.
///
/// In the biggest error a Google Engineer could make they 
/// attempted to copy implementation strategies for 
/// canonical layouts from android native to the flutter 
/// adaptive scaffold. Why was this a big error?
///
/// Android native navigatin is different as Android native 
/// has screen fragments whereas flutter does not in the 
/// navigation implementation. In short in Android native 
/// I can implement an adaptive scaffold MD3 pattern using 
/// multiple content body childred as the navigation 
/// implementation allows it while on Flutter we cannot 
/// do such constructs as the secondBody in error constructs 
/// in the flutter adaptive scaffold imply.
///
/// Thus one has to implement the adaptive scaffold pattern
/// needed manually using the codelabs sample as a guide:
///    see guide https://codelabs.developers.google.com/codelabs/flutter-animated-responsive-layout#8
///    see github code at https://github.com/flutter/codelabs/tree/main/animated-responsive-layout
///
/// Then once that is implemented one can use the 
/// dual screen package:
///   https://pub.dev/packages/dual_screen
/// And the surface duo flutter sdk samples as a guide:
///   https://github.com/microsoft/surface-duo-sdk-samples-flutter
/// To implement the canonical layouts needed using these 
/// helper classes.
///
/// Helper class for defining breakpoints for implementing
/// adaptive scaffolds with MD3. The method getWindowSize
/// returns the correct WindowSizeEnum per the BuildContext
/// MediaQuery results.
///
/// MD3 docs are at:
/// m3.material.io
///
/// Note, unlike MD2 we no longer have gutter and inserts are
/// somewhat handled at the content pane level of the canonical
/// layout.
///
/// Generally the call is
/// ```
///   Breakpoints.getWindowSize(context).begin;
///   Breakpoints.getWindowSize(context).end;
/// ```
///
/// @authot Fredrick Allan Grott
class Breakpoints {
  static WindowSizeEnum getWindowSize(BuildContext context) {
    if (isCompact(context)) {
      return WindowSizeEnum.compact;
    } else if (isMedium(context)) {
      return WindowSizeEnum.medium;
    } else if (isExpanded(context)) {
      return WindowSizeEnum.expanded;
    } else if (isLarge(context)) {
      return WindowSizeEnum.large;
    } else if (isExtra(context)) {
      return WindowSizeEnum.extra;
    } else {
      throw Exception('bad condition');
    }
  }

  
  /// Determines if the screen is in the compact window size.
  ///
  /// Returns `true` if the screen width is less than 600 pixels, `false` otherwise.
  static bool isCompact(BuildContext context) {
    return MediaQuery.of(context).size.width < WindowSizeEnum.medium.begin ? true : false;
  }

  /// Determines if the screen is in the medium window size.
  ///
  /// Returns `true` if the screen width is less than 840 pixels, `false` otherwise.
  static bool isMedium(BuildContext context) {
    return MediaQuery.of(context).size.width >= WindowSizeEnum.medium.begin &&
            MediaQuery.of(context).size.width < WindowSizeEnum.expanded.begin
        ? true
        : false;
  }

  /// Determines if the screen is in the expanded window size.
  ///
  /// Returns `true` if the screen width is less than 1200 pixels, `false` otherwise.
  static bool isExpanded(BuildContext context) {
    return MediaQuery.of(context).size.width >= WindowSizeEnum.expanded.begin &&
            MediaQuery.of(context).size.width < WindowSizeEnum.large.begin
        ? true
        : false;
  }

  /// Determines if the screen is in the large window size.
  ///
  /// Returns `true` if the screen width is less than 1600 pixels, `false` otherwise.
  static bool isLarge(BuildContext context) {
    return MediaQuery.of(context).size.width >= WindowSizeEnum.large.begin &&
            MediaQuery.of(context).size.width < WindowSizeEnum.extra.begin
        ? true
        : false;
  }

  /// Determines if the screen is in the extra window size.
  ///
  /// Returns `true` if the screen width is more than 1600 pixels, `false` otherwise.
  static bool isExtra(BuildContext context) {
    return MediaQuery.of(context).size.width >= WindowSizeEnum.extra.begin ? true : false;
  }
}

/// Model for Adaptive Scaffold implementations accoding
/// to Dart enumerated types. See Canonical Layouts for
/// Window Size class numbers at:
/// https://m3.material.io/foundations/layout/canonical-layouts/list-detail
///
/// @author Fredrick Allan Grott
enum WindowSizeEnum {
  /// The compact window size
  compact(0, 599),

  /// The medium window size
  medium(600, 839),

  /// The expanded window size
  expanded(840, 1199),

  /// The large window size
  large(1200, 1599),

  /// The extra window size
  extra(1600, double.infinity);

  /// The beginning of the range of window siaes
  final double begin;

  /// The end of the range of window sizes
  final double end;

  /// Creaqtes a new [WindowSizeEnum] with the given [begin] and [end] valuse
  const WindowSizeEnum(this.begin, this.end);
}


