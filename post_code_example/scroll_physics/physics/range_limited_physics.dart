import 'package:flutter/widgets.dart';

/// Ограничение диапазона прокрутки в пределах первых [maxDistanceFromTop] пикселей контента.
class RangeLimitedPhysics extends ScrollPhysics {
  /// Максимальное расстояние от верхней границы, доступное для скролла.
  final double maxDistanceFromTop;

  const RangeLimitedPhysics({required this.maxDistanceFromTop, super.parent});

  /// Комбинируем текущую физику с родительским поведением.
  @override
  RangeLimitedPhysics applyTo(ScrollPhysics? ancestor) =>
      RangeLimitedPhysics(maxDistanceFromTop: maxDistanceFromTop, parent: buildParent(ancestor));

  /// Граница минимального скролла.
  double _min(ScrollMetrics m) => m.minScrollExtent;

  /// Граница максимального скролла.
  double _max(ScrollMetrics m) => (m.minScrollExtent + maxDistanceFromTop).clamp(m.minScrollExtent, m.maxScrollExtent);

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    final double minAllowed = _min(position);
    final double maxAllowed = _max(position);

    // Не позволяем скролить ниже минимума
    // и выше максимума.
    if (value < minAllowed) {
      return value - minAllowed;
    }
    if (value > maxAllowed) {
      return value - maxAllowed;
    }
    // В остальных случаях делегируем родителю.
    return super.applyBoundaryConditions(position, value);
  }

  @override
  Simulation? createBallisticSimulation(ScrollMetrics position, double velocity) {
    // Если вышли за разрешённые границы — возвращаемся пружиной
    final double minAllowed = _min(position);
    final double maxAllowed = _max(position);
    if (position.pixels < minAllowed) {
      return ScrollSpringSimulation(spring, position.pixels, minAllowed, 0.0, tolerance: toleranceFor(position));
    }
    if (position.pixels > maxAllowed) {
      return ScrollSpringSimulation(spring, position.pixels, maxAllowed, 0.0, tolerance: toleranceFor(position));
    }

    // Внутри диапазона — делегируем родителю.
    return super.createBallisticSimulation(position, velocity);
  }
}
