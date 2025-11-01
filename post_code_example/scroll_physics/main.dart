import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const PhysicsDemoApp());
}

class PhysicsDemoApp extends StatelessWidget {
  const PhysicsDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scroll Physics Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
