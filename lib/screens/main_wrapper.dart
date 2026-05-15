import 'package:flutter/material.dart';
import 'dashboard/dashboard_screen.dart';
import 'expense/expense_screen.dart';
import 'analytics/analytics_screen.dart';
import 'subscriptions/subscription_screen.dart';
import 'settings/settings_screen.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0;

  // This list must match the order of your BottomNavigationBarItems
  final List<Widget> _pages = [
    const DashboardScreen(),
    const ExpenseScreen(),
    const AnalyticsScreen(),
    const SubscriptionScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The IndexedStack keeps the state of your pages alive 
      // (so you don't lose scroll position when switching tabs)
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.white10, width: 0.5)),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF0F172A), // Matches your deep navy theme
          selectedItemColor: Colors.cyanAccent,
          unselectedItemColor: Colors.white30,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline_rounded), label: "Add"),
            BottomNavigationBarItem(icon: Icon(Icons.analytics_outlined), label: "Stats"),
            BottomNavigationBarItem(icon: Icon(Icons.card_membership_rounded), label: "Subs"),
            BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: "Settings"),
          ],
        ),
      ),
    );
  }
}