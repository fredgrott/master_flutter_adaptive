// Copyright 2024 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.



import 'package:gorouter_part/src/breakpoints.dart';
import 'package:flutter/material.dart';

/// LayoutUtils to assist in implementing Canonical page layouts
/// to serves as content for an adaptive scaffold.
///
/// Generally the calls are:
/// ```
/// LayoutUtils.layoutSpacing(context);
/// LayoutUtils.getVisualDensity(context);
/// ```
///
/// Note: Text Scaling is achieved by wrapping the Scaffold
/// like this:
/// ```
/// MediaQuery.withClapedTextScaling(
///   maxScaleFactor: MediaQuery.texdtScalerOf(context),
///   child: ScaffoldWidget(),
/// )
/// ```
/// As we need one ancestor for it to work right and thus
/// have to do it below the MaterialApp widget.
/// As that will correct App text scaling when app user uses 
/// actual device settings to change text scaling for all 
/// platforms. Obviously its hinted lightly the flutter docs.
/// And obviously we never ever set text scaling via themes!
///
/// @author Fredrick Allan Grott
class LayoutUtils {
  /// Compact layout margin
 static double get compactLayoutMargin => 16;

  /// Medium layout margin
  static double get mediumLayoutMargin => 24;

  /// Expanded layout margin
  static double get expandedLayoutMargin => 24;

  /// Large layout margin
  static double get largeLayoutMargin => 32;

  /// Extra layout margin
  static double get extraLayoutMargin => 32;

  /// Content pane spacing
  static double get contentPaneSpacing => 24;

  /// Compact layout padding
  static double get compactLayoutPadding => 4;

  /// Medium layout padding
  static double get mediumLayoutPadding => 8;

  /// Expanded layout padding
  static double get expandedLayoutPadding => 12;

  /// Large layout padding
  static double get largeLayoutPadding => 16;

  /// Extra layout padding
  static double get extraLayoutPadding => 20;

  /// Returns to correct EdgeInsets per
  /// WindowSize class breakpoint with
  /// horizontal getting margin and
  /// vertical getting padding values.
  static EdgeInsetsGeometry layoutSpacing(BuildContext context) {
    if (Breakpoints.isCompact(context)) {
      return EdgeInsets.symmetric(
        horizontal: compactLayoutMargin,
        vertical: compactLayoutPadding,
      );
    } else if (Breakpoints.isMedium(context)) {
      return EdgeInsets.symmetric(
        horizontal: mediumLayoutMargin,
        vertical: mediumLayoutPadding,
      );
    } else if (Breakpoints.isExpanded(context)) {
      return EdgeInsets.symmetric(
        horizontal: expandedLayoutMargin,
        vertical: expandedLayoutPadding,
      );
    } else if (Breakpoints.isLarge(context)) {
      return EdgeInsets.symmetric(
        horizontal: largeLayoutMargin,
        vertical: largeLayoutPadding,
      );
    } else if (Breakpoints.isExtra(context)) {
      return EdgeInsets.symmetric(
        horizontal: extraLayoutMargin,
        vertical: extraLayoutPadding,
      );
    } else {
      throw UnimplementedError('Bad breakpoint');
    }
  }

  /// Per MD3 docs we do not set VisualDensity defauls
  /// but instead its implied that we need to set this via
  /// breakpoints. See class doc at
  /// https://api.flutter.dev/flutter/material/VisualDensity-class.html
  /// And MD3 doc at
  /// https://m3.material.io/foundations/layout/understanding-layout/spacing
  /// And probably the final polish setting some type of
  /// settings switch the flutter app settings to allow
  /// the user to adjust visual density themselves.
  /// And no, this is not directly in Flutter docs or
  /// Codelabs examples either.
  ///
  /// And yes the constants for VisualDensity have
  /// not been changed in the SDK yet to reflect
  /// alignment with the MD3 WindowSize class breakpoints.
  static VisualDensity getVisualDensity(BuildContext context) {
    if (Breakpoints.isCompact(context)) {
      return const VisualDensity(horizontal: -2.0, vertical: -2.0);
    } else if (Breakpoints.isMedium(context)) {
      return const VisualDensity(horizontal: -1.0, vertical: -1.0);
    } else if (Breakpoints.isExpanded(context)) {
      return const VisualDensity(horizontal: 0.0, vertical: 0.0);
    } else if (Breakpoints.isLarge(context)) {
      return const VisualDensity(horizontal: 2.0, vertical: 2.0);
    } else if (Breakpoints.isExtra(context)) {
      return const VisualDensity(horizontal: 4.0, vertical: 4.0);
    } else {
      throw Exception('bad condition');
    }
  }
}
