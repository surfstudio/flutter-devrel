import 'package:flutter/material.dart';
import '../physics/soft_snap_physics.dart';
import '../physics/range_limited_physics.dart';
import '../physics/mystery_scroll_physics.dart';
import 'list_view_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scroll Physics Demo'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Демонстрация различных типов физики скролла',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => _openPhysicsDemo(
                context,
                'SoftSnap Physics',
                const SoftSnapPhysics(itemExtent: 80),
                80.0,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('SoftSnap Physics', style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _openPhysicsDemo(
                context,
                'RangeLimited Physics',
                const RangeLimitedPhysics(maxDistanceFromTop: 500),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('RangeLimited Physics', style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _openPhysicsDemo(
                context,
                'Mystery Physics',
                const MysteryScrollPhysics(),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Mystery Physics', style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 32),
            const Text(
              'Каждая кнопка демонстрирует кастомное поведение скролла:',
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              '• SoftSnap - привязка к размеру элементов\n'
              '• RangeLimited - ограничение области скролла\n'
              '• Mystery - ???',
              style: TextStyle(fontSize: 12, color: Colors.grey),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }

  void _openPhysicsDemo(
    BuildContext context,
    String title,
    ScrollPhysics physics,
    [double? itemExtent]
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ListViewScreen(
          title: title,
          physics: physics,
          itemExtent: itemExtent,
        ),
      ),
    );
  }
}
