// Copyright 2024 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// [CustomScrollBehavior] to set web with the proper
/// scrollbar behavior as now as of Flutter 2.2 all widgets
/// that are scrollable get a scrollable configuration by
/// default.
///
/// Usage is:
/// ```
/// MaterialApp{
///   scrollBehavior: CustomScrollBehavior(),
/// )
/// ```
///
/// @author Fredrick Allan Grott
class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.invertedStylus,
        PointerDeviceKind.trackpad,
      };
}
