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
  State<IntervalAnimationExample> createState() => _IntervalAnimationExampleState();
}

class _IntervalAnimationExampleState extends State<IntervalAnimationExample> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Color?> _colorAnimation;
  late final Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();

    // Общий контроллер для всей анимации
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );

    // анимация цвета
    _colorAnimation = ColorTween(
      begin: Colors.red,
      end: Colors.blue,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        // анимация будет происходит в интервале с 0.3 до 0.8
        // (с 3 по 8 секунду)
        curve: const Interval(0.3, 0.8, curve: Curves.linear),
      ),
    );

    // анимация размера
    _sizeAnimation = Tween<double>(
      begin: 150,
      end: 200,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        // анимация будет происходит в интервале с 0.4 до 0.7
        // (с 4 по 7 секунду)
        curve: const Interval(0.4, 0.7, curve: Curves.easeInOut),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // запускаем анимацию
  void _startAnimation() {
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Interval Animation')),
      body: Center(
        // передаем контроллер в виджет
        // и передаем в поля цвета и размера значения анимаций
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Center(
                    child: Container(
                      width: _sizeAnimation.value,
                      height: _sizeAnimation.value,
                      color: _colorAnimation.value,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  child: LinearProgressIndicator(
                    value: _controller.value,
                    minHeight: 10,
                    backgroundColor: Colors.grey[300],
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                )
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
