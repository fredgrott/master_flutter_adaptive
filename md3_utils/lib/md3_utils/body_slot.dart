// Copyright 2024 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

/// Per MD3 we only have two or more panels
/// on Expanded and higher window sizes.
///
/// Note, default adaptive scaffold in flutter adaptive
/// scaffold is wrong in that it has small secondybody slots.
///
///  @autbor Fredrick Allan Grott
enum BodySlot {
  compactBodySlot,
  mediumBodySlot,
  expandedBodySlot,
  expandedSecondaryBodySlot,
  largeBodySlot,
  largeSecondaryBodySlot,
  extraLargeBodySlot,
  extraLargeSecondaryBodySlot,
}
