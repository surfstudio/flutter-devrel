import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tween Sequence Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
        ),
      ),
      home: const ShakingBellScreen(),
    );
  }
}

class ShakingBellScreen extends StatefulWidget {
  const ShakingBellScreen({super.key});

  @override
  _ShakingBellScreenState createState() => _ShakingBellScreenState();
}

class _ShakingBellScreenState extends State<ShakingBellScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Создаем контроллер анимации
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    // Создаем последовательность анимаций
    _animation = TweenSequence<double>(<TweenSequenceItem<double>>[
      // первый этап: поворот налево
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.1), weight: 1),
      // второй этап: поворот направо
      TweenSequenceItem(tween: Tween(begin: 0.1, end: -0.1), weight: 2),
      // третий этап: возвращение в исходное положение
      TweenSequenceItem(tween: Tween(begin: -0.1, end: 0.0), weight: 1),
    ]).animate(
      // связываем последовательность с контроллером
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _triggerShake() {
    if (_controller.status == AnimationStatus.completed || _controller.status == AnimationStatus.dismissed) {
      _controller.forward(from: 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Уведомления'),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.topRight,
          children: <Widget>[
            RotationTransition(
              turns: _animation,
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Icon(
                  Icons.notifications,
                  size: 50.0,
                ),
              ),
            ),
            Positioned(
              right: 12,
              top: 12,
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _triggerShake,
        child: const Icon(Icons.notifications_active),
      ),
    );
  }
}
