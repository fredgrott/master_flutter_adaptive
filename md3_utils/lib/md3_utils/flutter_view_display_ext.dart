// Copyright 2024 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.



import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:md3_utils/md3_utils/custom_window_size.dart';
import 'package:md3_utils/md3_utils/mq_data_ext.dart';
import 'package:universal_platform/universal_platform.dart';



/// A bit of tech debt handling as MediaQuery will 
/// not give the right Size of screens for foldables and 
/// desktop apps opening multiple windows. Thus we 
/// instead have to use FlutterView and grab the display
/// object to then get the screen specifics such as 
/// size, etc.
///
/// Keep in mind that preventing letterboxing
/// on android and iOS foldables has to be done in the scaffold
/// via:
/// ```
///  class _HomeState extends State<Home> with SingleTickerProviderStateMixin, WidgetsBindingObserver {
///  bool unfolding = false;
///  @override
///  void didChangeMetrics() {
///    super.didChangeMetrics();
///    final view = PlatformDispatcher.instance.implicitView!;
///    final logicalSize = view.physicalSize view.devicePixelRatio;
///
///
///    if (!unfolding) {
///      unfolding = view.displayFeatures.any(
///        (DisplayFeature feature) => feature.state ==
/// DisplayFeatureState.postureHalfOpened,
///      );
///    } else {
///      unfolding = !view.displayFeatures.any(
///        (DisplayFeature feature) => feature.state == DisplayFeatureState.postureFlat,
///      );
///    }
///
///    if (unfolding || logicalSize.shortestSide >= 600) {
///      SystemChrome.setPreferredOrientations([]);
///   } else if (logicalSize.shortestSide < 600) {
///      
///  SystemChrome.setPreferredOrientations(<DeviceOrientation>[DeviceOrientation.portraitUp,]);
///    }
///  }
///```
///
/// @author Fredrick Allan Grott
extension FlutterViewDisplayExt on BuildContext {


  ui.FlutterView get appView => View.of(this);

  ui.Display? get  appDisplay => appView.display;

  // set zero if null
  double? get appWidth => appDisplay?.size.width;

  // set zero if null
  double? get appHeight => appDisplay?.size.height;

  double? get appDevicePixelRatio => appDisplay?.devicePixelRatio;

  List<ui.DisplayFeature> get appDisplayFeatures => appView.displayFeatures;

  ui.ViewPadding get appViewPadding => appView.padding;

  Brightness get appBrightness => MediaQuery.platformBrightnessOf(this);

  double get appPixelsPerInch => UniversalPlatform.isAndroid || UniversalPlatform.isIOS ? 150 : 96;

  TextScaler get appTextScaler => MediaQuery.textScalerOf(this);


  Orientation get appOrientation => MediaQuery.orientationOf(this);

  bool isDisplayFolding() {
    final hinge = MediaQuery.of(this).hinge;
    if (hinge == null) {
      return false;
    } else {
      // vertical and horizontal
      return hinge.bounds.size.aspectRatio < 1 || hinge.bounds.size.aspectRatio > 1;
    }
  }


  // if higher then medium, two panes across then
  // if not higher then medium two panes stacked vertical
  // or horizontal based on mobile orientation.
  bool get isHigherThenMedium => appWidth! > CustomWindowSize.medium.endWidthRange;

  // I can re-use Microsoft's logic in the flutter
  // surface demos two pane layout to properly apply
  // margin and spacing if I have the hingeSize.
  // See source code:
  // https://github.com/microsoft/surface-duo-sdk-samples-flutter/blob/main/design_patterns/lib/two_page/two_page.dart
  Size get hingeSize => MediaQuery.of(this).hinge?.bounds.size ?? Size.zero;

  /// isRTL bool as we need to specify text direction as
  /// part of the two pane layout part of canonical layouts
  /// as the two or more content panes will reverse layout
  /// direction upon language direction of reading change
  bool get isRTL => Directionality.of(this) == ui.TextDirection.rtl;

  /// Returns an appWindowSize that contains the beginWidthRange, endWidthRange, margin,
  /// middleSpacing, and dimens
  CustomWindowSize get appWindowSize {
    if (appWidth! >= CustomWindowSize.compact.endWidthRange) {
      return CustomWindowSize.compact;
    } else if (appWidth! >= CustomWindowSize.medium.endWidthRange) {
      return CustomWindowSize.medium;
    } else if (appWidth! >= CustomWindowSize.expanded.endWidthRange) {
      return CustomWindowSize.expanded;
    } else if (appWidth! >= CustomWindowSize.large.endWidthRange) {
      return CustomWindowSize.large;
    } else {
      return CustomWindowSize.extraLarge;
    }
  }


}
