// Copyright 2024 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:adaptive_extras/src/global_context.dart';
import 'package:flutter/material.dart';

/// Usage is:
/// ```
///  isRTL() ? TextDirection.rtl: TextDirection.ltr;
/// ```
///
/// 
///
/// @author Fredrick Allan Grott
bool isRTL() => Directionality.of(routeAppContext).toString().contains(TextDirection.rtl as Pattern);
