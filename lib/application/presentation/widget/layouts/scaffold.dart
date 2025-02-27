import 'package:flutter/material.dart';

class ScaffoldApp extends StatelessWidget {
  final String title;
  final Widget body;
  const ScaffoldApp({super.key, required this.body, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        automaticallyImplyLeading: false,
        title: Text(title, style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: body,
    );
  }
}
