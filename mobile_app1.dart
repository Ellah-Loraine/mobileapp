import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lorin App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    ProfilePage(),
    MessagePage(),
    SettingsPage(),
  ];

  final List<String> _titles = ['Home', 'Profile', 'Message', 'Settings'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),

      // Drawer
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('Lorin'),
              accountEmail: Text('dlellah015@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  'E',
                  style: TextStyle(fontSize: 28, color: Colors.purple),
                ),
              ),
              decoration: BoxDecoration(color: Colors.purple),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                setState(() => _currentIndex = 0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                setState(() => _currentIndex = 1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.message),
              title: const Text('Message'),
              onTap: () {
                setState(() => _currentIndex = 2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                setState(() => _currentIndex = 3);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      body: _pages[_currentIndex],

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Message'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

// ── HOME PAGE ──────────────────────────────────────────
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.home, size: 80, color: Colors.purple),
          SizedBox(height: 16),
          Text(
            'Hi, Lorin!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('This is the Home page.', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}

// ── PROFILE PAGE ───────────────────────────────────────
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.purple,
            child: Text(
              'E',
              style: TextStyle(fontSize: 40, color: Colors.white),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Lorin',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text('dlellah015@example.com', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              foregroundColor: Colors.white,
            ),
            onPressed: () {},
            child: const Text('Edit Profile'),
          ),
        ],
      ),
    );
  }
}

// ── MESSAGE PAGE ───────────────────────────────────────
class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  final List<Map<String, String>> _messages = const [
    {'name': 'Jenna Cruz', 'msg': 'Hey! Are you free later?'},
    {'name': 'Marco Reyes', 'msg': 'Liked your post!'},
    {'name': 'Ana Santos', 'msg': 'Did you finish the assignment?'},
    {'name': 'Prof. Dela Cruz', 'msg': 'Reminder: Demo is on Friday.'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _messages.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final m = _messages[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.purple,
            child: Text(
              m['name']![0],
              style: const TextStyle(color: Colors.white),
            ),
          ),
          title: Text(
            m['name']!,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(m['msg']!),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {},
        );
      },
    );
  }
}

// ── SETTINGS PAGE ──────────────────────────────────────
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notifications = true;
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ListTile(
          leading: Icon(Icons.person, color: Colors.purple),
          title: Text('Edit Profile'),
          trailing: Icon(Icons.chevron_right),
        ),
        SwitchListTile(
          secondary: const Icon(Icons.notifications, color: Colors.purple),
          title: const Text('Notifications'),
          value: _notifications,
          activeColor: Colors.purple,
          onChanged: (val) => setState(() => _notifications = val),
        ),
        SwitchListTile(
          secondary: const Icon(Icons.dark_mode, color: Colors.purple),
          title: const Text('Dark Mode'),
          value: _darkMode,
          activeColor: Colors.purple,
          onChanged: (val) => setState(() => _darkMode = val),
        ),
        const ListTile(
          leading: Icon(Icons.help, color: Colors.purple),
          title: Text('Help'),
          trailing: Icon(Icons.chevron_right),
        ),
        const ListTile(
          leading: Icon(Icons.logout, color: Colors.red),
          title: Text('Sign Out', style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
