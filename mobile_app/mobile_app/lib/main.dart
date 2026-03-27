import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/profile_page.dart';
import 'pages/message_page.dart';
import 'pages/settings_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C63FF),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const MainScaffold(),
    );
  }
}

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;

  // Pages list
  static const List<Widget> _pages = [
    HomePage(),
    ProfilePage(),
    MessagePage(),
    SettingsPage(),
  ];

  // Drawer and BottomNav labels + icons
  static const List<_NavItem> _navItems = [
    _NavItem(label: 'Home',     icon: Icons.home_outlined,     activeIcon: Icons.home),
    _NavItem(label: 'Profile',  icon: Icons.person_outlined,   activeIcon: Icons.person),
    _NavItem(label: 'Messages', icon: Icons.chat_bubble_outline, activeIcon: Icons.chat_bubble),
    _NavItem(label: 'Settings', icon: Icons.settings_outlined, activeIcon: Icons.settings),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    Navigator.of(context).pop(); // close drawer if open
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ── AppBar ──────────────────────────────────────────────────────────
      appBar: AppBar(
        title: Text(_navItems[_selectedIndex].label),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 2,
      ),

      // ── Drawer ──────────────────────────────────────────────────────────
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hero wraps the avatar so it animates when navigating
                  Hero(
                    tag: 'profile-avatar',
                    child: CircleAvatar(
                      radius: 36,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Welcome!',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            // Drawer items with icons
            for (int i = 0; i < _navItems.length; i++)
              ListTile(
                leading: Icon(
                  i == _selectedIndex ? _navItems[i].activeIcon : _navItems[i].icon,
                  color: i == _selectedIndex
                      ? Theme.of(context).colorScheme.primary
                      : null,
                ),
                title: Text(_navItems[i].label),
                selected: i == _selectedIndex,
                selectedTileColor: Theme.of(context).colorScheme.primaryContainer,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                onTap: () => _onItemTapped(i),
              ),
          ],
        ),
      ),

      // ── Body ─────────────────────────────────────────────────────────────
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 350),
        transitionBuilder: (child, animation) {
          // Page-route fade + slide transition
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.05, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
        child: KeyedSubtree(
          key: ValueKey<int>(_selectedIndex),
          child: _pages[_selectedIndex],
        ),
      ),

      // ── Bottom Navigation Bar ─────────────────────────────────────────────
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: _navItems
            .map(
              (item) => BottomNavigationBarItem(
                icon: Icon(item.icon),
                activeIcon: Icon(item.activeIcon),
                label: item.label,
              ),
            )
            .toList(),
      ),
    );
  }
}

// Simple data class for nav items
class _NavItem {
  final String label;
  final IconData icon;
  final IconData activeIcon;
  const _NavItem({required this.label, required this.icon, required this.activeIcon});
}
