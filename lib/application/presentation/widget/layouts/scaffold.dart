import 'package:abbon_mobile_test/application/presentation/shared/theme/color.dart';
import 'package:flutter/material.dart';

class ScaffoldApp extends StatelessWidget {
  final String title;
  final Widget body;
  final bool appBar;
  const ScaffoldApp({super.key, required this.body, required this.title, this.appBar = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorThemeApp.background,
      resizeToAvoidBottomInset: false,
      appBar:
          appBar
              ? AppBar(
                backgroundColor: ColorThemeApp.background,
                automaticallyImplyLeading: false,
                title: Text(title, style: Theme.of(context).textTheme.headlineSmall),
              )
              : null,
      body: body,
    );
  }
}
