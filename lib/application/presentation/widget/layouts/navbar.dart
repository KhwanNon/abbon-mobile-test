import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavbarApp extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  const NavbarApp({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

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
            _buildNavItem(CupertinoIcons.home, "Home", 0),
            _buildNavItem(CupertinoIcons.phone, "Contact", 1),
            _buildNavItem(CupertinoIcons.settings, "Settings", 2),
          ],
        ),
      ),
    );
  }

  NavigationDestination _buildNavItem(IconData icon, String label, int index) {
    return NavigationDestination(
      icon: Icon(
        icon,
        color: selectedIndex == index ? Colors.blueAccent : Colors.grey,
      ),
      label: label,
    );
  }
}
