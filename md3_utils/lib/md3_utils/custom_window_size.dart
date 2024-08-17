// Copyright 2024 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
//
// Note I added this as code comment to WindowSize class
// issue at github to see if Google will use it.




/// Part of Tech Debt adjustment as the 
/// flutter adaptive scaffold is somewhat wrong in
/// not having adjusted to MD3 spec changes and the
/// new Flutter View API and new way to get 
/// screen dimensions instead of media query.
///
/// Per MD3 spec we have:
///  screen width        margin spacing
/// compact 0-599            16 0
/// medium  600-839          24 24
/// expanded 840-1199        24 24
/// large   1200-1599        24 24
/// extraLarge 1600-infinity 24 24
///
///  screen     vertDensity   hortDensity   padding
///  compact           0         0             4
///  medium            -0.5    -0.5            8
///  expanded          -1.0    -1.0            12
///  large             -2.0    -2.0            16
///  extraLarge        -3.0    -3.0            20
///
///  Insider stuff, the flutter_adaptive_scaffold 
///  team has inside access to MD3 spec changes and 
///  uses some of them while not handling tech debt.
///  They started using screen heights:
///
///   screen    height
///    compact   0-900
///    medium    480-900
///    expanded  900-infinity
///    large     900-infinity
///    extraLarge 900-infinity
///
///  Note due to changes to multiple views (screens) and
///  foldables we can no longer use MediaQuery for screen
///  Sizes but instead have to use FlutterView and grab the
///  Display object to then use the Display API to get 
///  screen sizes. This is why certain outside packages 
///  have not updated per this tech debt such as GSkinner's 
///  sized context package.
///
///  VisualDensity adjustment is then made via wrapping 
///  the shared scaffold nav UI in a theme widget like this:
///  ```
///  Theme(
///        data: Theme.of(context).copyWith(visualDensity: VisualDensity(horizontal: context.appWindowSize.visualHorz, verical: context.appWindowSize.visualVert),
///         child: child,
///     )
///   ```
///
/// Which will do the proper information density
/// adjustment to checkbox, chip, elevatedbutton, 
/// iconbutton, inputdecorator, listtile, etc.
///
/// @author Fredrick Allan Grott
enum CustomWindowSize {
  compact(0, 599,0,900, 16, 0, 0, 0, 4),
  medium(600, 839,480,900, 24, 24, -0.5, -0.5, 8),
  expanded(840, 1199,900, double.infinity, 24, 24, -1.0, -1.0, 12),
  large(1200, 1599, 900, double.infinity, 24, 24, -2.0, -2.0, 16),
  extraLarge(1600, double.infinity,900, double.infinity, 24, 24, -3.0, -3.0, 20);


  const CustomWindowSize(
      this.beginWidthRange, this.endWidthRange, this.beginHeightRange, this.endHeightRange, this.margin, this.spacing, this.visualHorz, this.visualVert, this.padding,);




  /// the begin width range
  final double beginWidthRange;

  /// the end width range
  final double endWidthRange;

  /// begin height range
  final double beginHeightRange;

  /// end height range
  final double endHeightRange;

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
