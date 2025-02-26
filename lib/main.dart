import 'package:abbon_mobile_test/application/presentation/routres/name.dart';
import 'package:abbon_mobile_test/application/presentation/routres/pages.dart';
import 'package:abbon_mobile_test/application/presentation/shared/theme/text.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: AppTextTheme.light),
      darkTheme: ThemeData(textTheme: AppTextTheme.dark),
      initialRoute: RouteName.splash, // Initial route for the app
      routes: RoutePages.routesPageAll, // Define app routes
    );
  }
}
