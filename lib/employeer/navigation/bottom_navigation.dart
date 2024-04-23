import 'package:flutter/material.dart';
import 'package:philjobnet/employeer/screens/dashboard.dart';
import 'package:philjobnet/employeer/screens/message.dart';
import 'package:philjobnet/employeer/screens/notification.dart';
import 'package:philjobnet/employeer/screens/profile.dart';
import 'package:philjobnet/services/navigation/custom_bottom_navigation.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  // INITIALIZE INDEX
  static const int _defaultIndex = 0;
  int _selectedIndex = _defaultIndex;

  // LIST OF PAGES
  final List<Widget> _pages = [
    const DashboardScreen(),
    const MessageScreen(),
    const NotificationScreen(),
    const ProfileScreen(),
  ];

  // NAVIGATE TO BAR ITEMS
  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          // HOME
          NavigationUtils.buildBottomNavigationBarItem(
            selectedIcon: Icons.home_rounded,
            unselectedIcon: Icons.home_outlined,
            label: "Home",
            index: 0,
            selectedIndex: _selectedIndex,
            isClient: false,
          ),
          // MESSAGE
          NavigationUtils.buildBottomNavigationBarItem(
            selectedIcon: Icons.email_rounded,
            unselectedIcon: Icons.email_outlined,
            label: "Message",
            index: 1,
            selectedIndex: _selectedIndex,
            isClient: false,
          ),
          // NOTIFICATION
          NavigationUtils.buildBottomNavigationBarItem(
            selectedIcon: Icons.notifications,
            unselectedIcon: Icons.notifications_none,
            label: "Notification",
            index: 2,
            selectedIndex: _selectedIndex,
            isClient: false,
          ),
          // PROFILE
          NavigationUtils.buildBottomNavigationBarItem(
            selectedIcon: Icons.person,
            unselectedIcon: Icons.person_outline,
            label: 'Profile',
            index: 3,
            selectedIndex: _selectedIndex,
            isClient: false,
          ),
        ],
        backgroundColor: const Color(0xFFFEFFFE),
        unselectedFontSize: 11,
        selectedFontSize: 12,
        selectedItemColor: const Color(0xFF3C3C40),
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
