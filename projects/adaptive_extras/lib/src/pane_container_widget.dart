// Copyright 2024 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:adaptive_extras/src/layout_utils.dart';
import 'package:adaptive_extras/src/new_surface_theme.dart';
import 'package:adaptive_extras/src/surface_color_enum.dart';
import 'package:adaptive_extras/src/text_direction.dart';
import 'package:flutter/material.dart';

/// The [PaneContainerWidget] is a wrapper widget for widgets that are inserted inside the
/// [PageLayout]. The container allows you to select the surface background color, container
/// dimensions, and border radius.
class PaneContainerWidget extends StatelessWidget {
  /// The child widget to be wrapped with the container.
  final Widget child;

  /// The color of the surface of the container. Defaults to [SurfaceColorEnum.surface].
  final SurfaceColorEnum surfaceColor;

  
  /// The width of the container. Defaults to [double.infinity].
  final double width;

  /// The height of the container. Defaults to [double.infinity].
  final double height;

  /// The top border radius for the container. Defaults to 12.
  final double topBorderRadius;

  /// The bottom border radius for the container. Defaults to 12.
  final double bottomBorderRadius;

  /// The [PaneContainerWidget] is a wrapper widget for widgets that are inserted inside the
  /// [PageLayout]. The container allows you to select the surface background color, container
  /// dimensions, and border radius.
  ///
  /// Example of usage:
  ///
  /// ```dart
  /// PaneContainerWidget(
  ///   child: YourWidget(),
  ///   surfaceColor: SurfaceColorEnum.primaryVariant,
  ///   padding: EdgeInsets.all(16),
  /// )
  /// ```
  const PaneContainerWidget({
    super.key,
    required this.child,
    this.surfaceColor = SurfaceColorEnum.surface,
    this.height = double.infinity,
    this.width = double.infinity,
    this.topBorderRadius = 12,
    this.bottomBorderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      // I refrain from inserting global context into things
      // before the build unless I really need it thus
      // instead I put it here. As one would not want to
      // vary this as then it would not be MD3 compliant.
      padding: LayoutUtils.layoutSpacing(context).resolve(isRTL() ? TextDirection.rtl : TextDirection.ltr),
      child: Material(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(topBorderRadius),
          bottom: Radius.circular(bottomBorderRadius),
        ),
        color: NewSurfaceTheme.getSurfaceColor(surfaceColor, context),
        child: SizedBox(
          width: width,
          height: height,
          child: child,
        ),
      ),
    );
  }
}
