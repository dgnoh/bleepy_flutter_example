import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void openBleepyLauncher(BuildContext context) {
    Navigator.pushNamed(context, '/bleepy');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        child: Scaffold(
        body: Center(child: OutlinedButton(
            onPressed: () => openBleepyLauncher(context),
        child: const Text('Bleepy'))),
    )
    );
  }
}
