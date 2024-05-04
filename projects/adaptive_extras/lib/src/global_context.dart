// Copyright 2024 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';


/// [scaffoldMessengerKey] is used as a parameter in the MaterialApp 
/// main construct for Nav 1.0 and in the MaterialApp.rotuer construct
/// for Nav 2.0 as a way to grab the context outside of the widgets 
/// and UI for use in such things as localizations outside of UI in 
/// models for example among other usages.
final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

/// [routerAppContext] is used in things like text direction and 
/// localization calls outside of the UI, etc.
BuildContext routeAppContext = scaffoldMessengerKey.currentContext!;




