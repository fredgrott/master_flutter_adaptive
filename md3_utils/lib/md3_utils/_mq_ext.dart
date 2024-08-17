// Copyright 2024 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:md3_utils/md3_utils/mq_data_ext.dart';
import 'package:md3_utils/md3_utils/window_size.dart';
import 'package:universal_platform/universal_platform.dart';

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
///  SystemChorme.setPreferredOrientations(<DeviceOrientation>[DeviceOrientation.portraitUp,]);
///    }
///  }
///```
///
/// @author Fredick Allan Grott
extension MQExt on BuildContext {
  double get appAspectRatio => MediaQuery.sizeOf(this).aspectRatio;
  Brightness get appBrightness => MediaQuery.platformBrightnessOf(this);
  double get appDevicePixelRatio => MediaQuery.devicePixelRatioOf(this);
  List<ui.DisplayFeature> get appDisplayFeatures => MediaQuery.displayFeaturesOf(this);
  double get appHeight => MediaQuery.sizeOf(this).height;

  double get appPixelsPerInch => UniversalPlatform.isAndroid || UniversalPlatform.isIOS ? 150 : 96;

  TextScaler get appTextScaler => MediaQuery.textScalerOf(this);
  EdgeInsets get appViewPadding => MediaQuery.viewPaddingOf(this);
  double get appWidth => MediaQuery.sizeOf(this).width;

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
  bool get isHigherThenMedium => appWidth > WindowSize.medium.endWidthRange;

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
  WindowSize get appWindowSize {
    if (appWidth >= WindowSize.compact.endWidthRange) {
      return WindowSize.compact;
    } else if (appWidth >= WindowSize.medium.endWidthRange) {
      return WindowSize.medium;
    } else if (appWidth >= WindowSize.expanded.endWidthRange) {
      return WindowSize.expanded;
    } else if (appWidth >= WindowSize.large.endWidthRange) {
      return WindowSize.large;
    } else {
      return WindowSize.extraLarge;
    }
  }
}
