import 'package:flutter/widgets.dart';

/// Мягкий щелчок к кратному itemExtent в конце инерции.
class SoftSnapPhysics extends ScrollPhysics {
  /// Размер элемента вдоль полосы прокрутки.
  final double itemExtent;

  const SoftSnapPhysics({required this.itemExtent, super.parent});

  /// Комбинируем текущую физику с родительским поведением.
  @override
  SoftSnapPhysics applyTo(ScrollPhysics? ancestor) =>
      SoftSnapPhysics(itemExtent: itemExtent, parent: buildParent(ancestor));

  /// Создаем симуляцию инерции.
  @override
  Simulation? createBallisticSimulation(ScrollMetrics position, double velocity) {
    // Если нет явной инерции — ничего не меняется
    final toleranceForPosition = toleranceFor(position);
    if (velocity.abs() < toleranceForPosition.velocity) return null;

    final double current = position.pixels;
    // Округляем к ближайшей «ячейке»
    final double targetCell = (current / itemExtent).roundToDouble();
    final double target = targetCell * itemExtent;

    /// Возвращаем нужну симуляцию инерции.
    return ScrollSpringSimulation(spring, current, target, velocity, tolerance: toleranceForPosition);
  }
}
