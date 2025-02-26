import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("SplashPage", style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}
