import 'package:flutter/widgets.dart';

class MysteryScrollPhysics extends ScrollPhysics {
  const MysteryScrollPhysics({super.parent});

  @override
  MysteryScrollPhysics applyTo(ScrollPhysics? ancestor) => MysteryScrollPhysics(parent: buildParent(ancestor));

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    return offset * 1 / 3.0;
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    final double minAllowed = position.minScrollExtent;
    final double minWithOverscroll = minAllowed - 10.0;

    if (value < minWithOverscroll) {
      return value - minWithOverscroll;
    }

    return super.applyBoundaryConditions(position, value);
  }

  @override
  double get minFlingVelocity => 100.0;
}
