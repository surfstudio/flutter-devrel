import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: IntervalAnimationExample(),
    );
  }
}

class IntervalAnimationExample extends StatefulWidget {
  const IntervalAnimationExample({super.key});

  @override
  State<IntervalAnimationExample> createState() =>
      _IntervalAnimationExampleState();
}

class _IntervalAnimationExampleState extends State<IntervalAnimationExample>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    // Cоздаем контроллер анимации
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );

    // Cоздаем анимацию цвета
    _colorAnimation = ColorTween(
      begin: Colors.red,
      end: Colors.blue,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        // эффект анимации будет происходит в интервале с 0.3 до 0.8
        // (с 3 по 8 секунду)
        curve: const Interval(0.3, 0.8, curve: Curves.linear),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Interval Animation')),
      body: Center(
        // передаем анимацию цвета в виджет
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  color: _colorAnimation.value,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 150,
                  child: LinearProgressIndicator(
                    value: _controller.value,
                    minHeight: 10,
                    backgroundColor: Colors.grey[300],
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _startAnimation,
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
