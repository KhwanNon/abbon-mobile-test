import 'package:abbon_mobile_test/application/presentation/shared/theme/color.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavbarApp extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  const NavbarApp({super.key, required this.selectedIndex, required this.onTabSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 2,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: NavigationBar(
          height: 65,
          indicatorColor: Colors.transparent,
          selectedIndex: selectedIndex,
          onDestinationSelected: onTabSelected,
          destinations: [
            _buildNavItem(CupertinoIcons.home, "app.navbar.home".tr(), 0, ColorThemeApp.primary),
            _buildNavItem(CupertinoIcons.phone, "app.navbar.contact".tr(), 1, Colors.green),
            _buildNavItem(CupertinoIcons.settings, "app.navbar.setting".tr(), 2, Colors.blueGrey),
          ],
        ),
      ),
    );
  }

  NavigationDestination _buildNavItem(IconData icon, String label, int index, Color iconColor) {
    return NavigationDestination(
      icon: Icon(icon, color: selectedIndex == index ? iconColor : Colors.grey),
      label: label,
    );
  }
}
