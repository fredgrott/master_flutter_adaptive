


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


/// An internal representation of a child widget subtree that is a child of
/// the [AnimatedIndexedStack].
///
/// This keeps track of animation controllers, keys, and the child widget.
class ChildEntry {
  ChildEntry({
    required this.key,
    required this.primaryController,
    required this.secondaryController,
    required this.child,
  });

  /// The key of this entry.
  /// This is usually a [GlobalKey] to ensure that children do not lose their state.
  final Key key;

  /// The animation controller for the child's transition.
  final AnimationController primaryController;

  /// The (curved) animation being used to drive the transition.
  final AnimationController secondaryController;
  Widget child;

  /// Release the resources used by this object.
  ///
  /// The object is no longer usable after this method is called.
  void dispose() {
    primaryController.dispose();
    secondaryController.dispose();
  }

  @override
  String toString() => 'AnimatedIndexedStackEntry#${shortHash(this)}($child)';
}