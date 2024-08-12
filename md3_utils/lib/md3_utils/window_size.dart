// Copyright 2024 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
//
// Note I added this as code comment to WindowSize class
// issue at github to see if Google will use it.

/// Per the layout part of the Material Design 3 spec we
/// have these window size classes with these values:
///           width         margin middle-spacing
///   compact 0-599            16         0
///   medium  600-839          24         24
///   expanded 840-1199        24         24
///   large    1200-1599       24         24
///   extralarge 1600-infinity 24         24
///
/// But, information denisty also has to be adjusted due
/// to sets of OS-platforms having outsised large device
/// forms; namely mobile OSes with AndroidTV and iOSTV and
/// desktop OSes with device forms larger than laptop.
///
/// The VisualDensity class sets defaultDensityPlatform
/// for android, iOS, and fuschia at standard which is
/// 0 for both horizontal and vertical. Then desktop is
/// set for -2.0.
///
/// This is a comanion enum to the SizeContext extension
/// which then uses the WindowSize width ranges to determine
/// according to size width which WindowZize enum is
/// returned. This means in both scaffold layout and
/// canonical layouts the calls to use are:
///
///   ```
///  context.appWindowSize.endWidthRange
///  context.appWindowSize.margin
///  context.appWindowSize.middleSpacing
///  ```
///
///  Visual Density is handled by wrapping the scaffold in
///  a theme widget, like:
///
///   ```
///     Theme(
///        data: Theme.of(context).copyWith(visualDensity: VisualDensity(horizontal: context.appWindowSize.visualHorz, verical: context.appWindowSize.cisualVert),
///         child: child,
///     )
///   ```
///
///  That Theme Widget code then will adjust the
///  information density per WindowSize class for
///  Checkbox, Chip, ElevatedButton, IconButton,
///  InputDecorator, ListTile, MaterialButton,
///  OutlinedButton, Radio, RawMaterialButton,
///  and TextButton.
///
/// @author Fredrick Allan Grott
enum WindowSize {
  compact(0, 599, 16, 0, 0, 0, 4),
  medium(600, 839, 24, 24, -0.5, -0.5, 8),
  expanded(840, 1199, 24, 24, -1.0, -1.0, 12),
  large(1200, 1599, 24, 24, -2.0, -2.0, 16),
  extraLarge(1600, double.infinity, 24, 24, -3.0, -3.0, 20);

  const WindowSize(
      this.beginWidthRange, this.endWidthRange, this.margin, this.spacing, this.visualHorz, this.visualVert, this.padding,);

  /// the begin width range
  final double beginWidthRange;

  /// the end width range
  final double endWidthRange;

  /// the margin
  final double margin;

  /// the middle spacing between panels of content
  /// only available in expanded and above
  final double spacing;

  /// visual horz density
  final double visualHorz;

  /// visual density vert
  final double visualVert;

  /// padding, md3 implied increments by 4dp
  final double padding;
}
