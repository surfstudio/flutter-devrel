import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Главный экран')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ScreenWithError()),
                );
              },
              child: const Text('Экран 1 (с ошибкой)'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ScreenFixed()),
                );
              },
              child: const Text('Экран 2 (без ошибки)'),
            ),
          ],
        ),
      ),
    );
  }
}

class ScreenWithError extends StatefulWidget {
  const ScreenWithError({super.key});

  @override
  State<ScreenWithError> createState() => _ScreenWithErrorState();
}

class _ScreenWithErrorState extends State<ScreenWithError> {
  @override
  void initState() {
    super.initState();

    // ❌ Неправильный способ — контекст ещё не готов
    showDialog(
      context: context,
      builder: (_) => const AlertDialog(
        title: Text('Открыт экран 1'),
        content: Text('Диалог вызван из initState() — будет ошибка'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Экран 1 (с ошибкой)')),
      body: const Center(child: Text('Проверка вызова диалога в initState')),
    );
  }
}

class ScreenFixed extends StatefulWidget {
  const ScreenFixed({super.key});

  @override
  State<ScreenFixed> createState() => _ScreenFixedState();
}

class _ScreenFixedState extends State<ScreenFixed> {
  @override
  void initState() {
    super.initState();

    // ✅ Правильный способ — ждем, пока фрейм будет построен
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          title: Text('Открыт экран 2'),
          content: Text('Диалог вызван через addPostFrameCallback() — без ошибки'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Экран 2 (без ошибки)')),
      body: const Center(child: Text('Проверка вызова диалога через addPostFrameCallback')),
    );
  }
}