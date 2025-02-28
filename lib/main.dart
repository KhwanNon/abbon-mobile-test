import 'package:abbon_mobile_test/application/logic/bloc/contact/contact_bloc.dart';
import 'package:abbon_mobile_test/application/presentation/routres/name.dart';
import 'package:abbon_mobile_test/application/presentation/routres/pages.dart';
import 'package:abbon_mobile_test/application/presentation/shared/navigator_helper.dart';
import 'package:abbon_mobile_test/application/presentation/shared/theme/text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('th', 'TH')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => ContactBloc())],
      child: MaterialApp(
        title: 'Flutter Demo',
        navigatorKey: NavigatorHelper.navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(textTheme: AppTextTheme.light),
        darkTheme: ThemeData(textTheme: AppTextTheme.dark),
        initialRoute: RouteName.main,
        routes: RoutePages.routesPageAll,
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
      ),
    );
  }
}
