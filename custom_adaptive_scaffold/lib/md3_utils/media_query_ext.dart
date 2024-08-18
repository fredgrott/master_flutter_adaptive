// Copyright 2024 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:md3_utils/md3_utils/custom_window_size.dart';
import 'package:md3_utils/md3_utils/mq_data_ext.dart';
import 'package:universal_platform/universal_platform.dart';

/// When FlutterEngine changed to support
/// multiple views and windows, MediaQueryData was
/// changed to access size and other stuff from FlutterView
/// and thus now Size works on foldables. But, now we
/// need to use the specific MediaQuery methods to
/// prevent excess builds as MediaQuery.of(context) will
/// return the full  inherited MediaQueryData object so we
/// avoid calling that method.
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
extension MediaQueryExt on BuildContext {
  bool get appAccessibleNavigation => MediaQuery.accessibleNavigationOf(this);

  bool get appAlwaysUse24HourFormat => MediaQuery.alwaysUse24HourFormatOf(this);

  bool get appBoldText => MediaQuery.boldTextOf(this);

  Brightness get appBrightness => MediaQuery.platformBrightnessOf(this);

  double get appDevicePixelRatio => MediaQuery.devicePixelRatioOf(this);

  bool get appDisableAnimations => MediaQuery.disableAnimationsOf(this);

  List<ui.DisplayFeature> get appDisplayFeatures => MediaQuery.displayFeaturesOf(this);

  bool get appInvertColors => MediaQuery.invertColorsOf(this);

  bool get appHighContrast => MediaQuery.highContrastOf(this);

  NavigationMode get appNavigationMode => MediaQuery.navigationModeOf(this);

  bool get appOnOffSwitchLabels => MediaQuery.onOffSwitchLabelsOf(this);

  Orientation get appOrientation => MediaQuery.orientationOf(this);

  EdgeInsets get appPadding => MediaQuery.paddingOf(this);

  double get appScreenHeight => MediaQuery.sizeOf(this).height;

  double get appScreenWidth => MediaQuery.sizeOf(this).width;

  bool get appSupportShowingSystemContextMenu => MediaQuery.supportsShowingSystemContextMenu(this);

  EdgeInsets get appSystemGestureInsets => MediaQuery.systemGestureInsetsOf(this);

  TextScaler get appTextScaler => MediaQuery.textScalerOf(this);

  EdgeInsets get appViewInsets => MediaQuery.viewInsetsOf(this);

  // if higher then medium, two panes across then
  // if not higher then medium two panes stacked vertical
  // or horizontal based on mobile orientation.
  bool get isHigherThenMedium => appScreenWidth > CustomWindowSize.medium.endWidthRange;

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
    if (appScreenWidth >= CustomWindowSize.compact.endWidthRange) {
      return CustomWindowSize.compact;
    } else if (appScreenWidth >= CustomWindowSize.medium.endWidthRange) {
      return CustomWindowSize.medium;
    } else if (appScreenWidth >= CustomWindowSize.expanded.endWidthRange) {
      return CustomWindowSize.expanded;
    } else if (appScreenWidth >= CustomWindowSize.large.endWidthRange) {
      return CustomWindowSize.large;
    } else {
      return CustomWindowSize.extraLarge;
    }
  }

  /// Retruns pixels per inch
  double get appPixelsPerInch => UniversalPlatform.isAndroid || UniversalPlatform.isIOS ? 150 : 96;

  /// Computes spacing and margins for
  /// layouts per WindowSize and orientation and
  /// returns an [EdgeInsetsGeomtry] object
  EdgeInsetsGeometry get appLayoutSpacing {
    if (appOrientation == Orientation.landscape) {
      if (appScreenWidth >= CustomWindowSize.compact.endWidthRange) {
        return EdgeInsets.symmetric(
          horizontal: CustomWindowSize.compact.padding,
          vertical: CustomWindowSize.compact.margin,
        );
      } else if (appScreenWidth >= CustomWindowSize.medium.endWidthRange) {
        return EdgeInsets.symmetric(
          horizontal: CustomWindowSize.medium.padding,
          vertical: CustomWindowSize.medium.margin,
        );
      } else if (appScreenWidth >= CustomWindowSize.expanded.endWidthRange) {
        return EdgeInsets.symmetric(
          horizontal: CustomWindowSize.expanded.padding,
          vertical: CustomWindowSize.expanded.margin,
        );
      } else if (appScreenWidth >= CustomWindowSize.large.endWidthRange) {
        return EdgeInsets.symmetric(
          horizontal: CustomWindowSize.large.padding,
          vertical: CustomWindowSize.large.margin,
        );
      } else {
        return EdgeInsets.symmetric(
          horizontal: CustomWindowSize.extraLarge.padding,
          vertical: CustomWindowSize.extraLarge.margin,
        );
      }
    } else {
      if (appScreenWidth >= CustomWindowSize.compact.endWidthRange) {
        return EdgeInsets.symmetric(
          horizontal: CustomWindowSize.compact.margin,
          vertical: CustomWindowSize.compact.padding,
        );
      } else if (appScreenWidth >= CustomWindowSize.medium.endWidthRange) {
        return EdgeInsets.symmetric(
          horizontal: CustomWindowSize.medium.margin,
          vertical: CustomWindowSize.medium.padding,
        );
      } else if (appScreenWidth >= CustomWindowSize.expanded.endWidthRange) {
        return EdgeInsets.symmetric(
          horizontal: CustomWindowSize.expanded.margin,
          vertical: CustomWindowSize.expanded.padding,
        );
      } else if (appScreenWidth >= CustomWindowSize.large.endWidthRange) {
        return EdgeInsets.symmetric(
          horizontal: CustomWindowSize.large.margin,
          vertical: CustomWindowSize.large.padding,
        );
      } else {
        return EdgeInsets.symmetric(
          horizontal: CustomWindowSize.extraLarge.margin,
          vertical: CustomWindowSize.extraLarge.padding,
        );
      }
    }
  }
}
