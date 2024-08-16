// Copyright 2024 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:md3_utils/md3_utils/body_slot.dart';

class BodySlotInherited extends InheritedWidget {
  const BodySlotInherited({
    super.key,
    required this.data,
    required this.child,
  }) : super(child: child);

  final BodySlot data;

  @override
  // ignore: overridden_fields
  final Widget child;

  static BodySlotInherited? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BodySlotInherited>();
  }

  static BodySlotInherited of(BuildContext context) {
    final BodySlotInherited? result = maybeOf(context);
    assert(result != null, "no bodyslotinheited found");
    return result!;
  }

  @override
  bool updateShouldNotify(BodySlotInherited oldWidget) => data != oldWidget.data;
}
