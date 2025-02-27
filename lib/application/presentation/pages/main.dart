import 'package:abbon_mobile_test/application/logic/bloc/contact/contact_bloc.dart';
import 'package:abbon_mobile_test/application/presentation/routres/pages.dart';
import 'package:abbon_mobile_test/application/presentation/widget/layouts/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    context.read<ContactBloc>().add(OnRandomContact());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            IndexedStack(
              index: _selectedIndex,
              children: const [
                RoutePages.home,
                RoutePages.contact,
                RoutePages.setting,
              ],
            ),
            NavbarApp(
              selectedIndex: _selectedIndex,
              onTabSelected: _onTabSelected,
            ),
          ],
        ),
      ),
    );
  }
}
