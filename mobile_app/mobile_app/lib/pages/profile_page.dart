import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),

          // ── Hero Animation ────────────────────────────────────────────
          // Tapping the avatar navigates to a detail screen with Hero transition
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(_heroRoute());
            },
            child: Hero(
              tag: 'profile-avatar',
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: const Icon(Icons.person, size: 64, color: Colors.white),
              ),
            ),
          ),

          const SizedBox(height: 12),
          Text(
            'John Doe',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const Text(
            'Flutter Developer',
            style: TextStyle(color: Colors.grey, fontSize: 15),
          ),

          const SizedBox(height: 8),
          const Text(
            '(Tap the avatar to see the Hero animation!)',
            style: TextStyle(color: Colors.blueGrey, fontSize: 12, fontStyle: FontStyle.italic),
          ),

          const SizedBox(height: 24),

          // ── Stats row ─────────────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _StatTile(label: 'Posts',     value: '128'),
              _StatTile(label: 'Followers', value: '4.2K'),
              _StatTile(label: 'Following', value: '312'),
            ],
          ),

          const SizedBox(height: 24),

          // ── Info tiles ────────────────────────────────────────────────
          _infoTile(Icons.email,    'johndoe@email.com'),
          _infoTile(Icons.phone,    '+63 912 345 6789'),
          _infoTile(Icons.location_on, 'Bacolod City, Philippines'),
          _infoTile(Icons.cake,     'January 1, 2000'),
        ],
      ),
    );
  }

  Widget _infoTile(IconData icon, String text) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF6C63FF)),
        title: Text(text),
      ),
    );
  }

  // Page route with Hero animation and custom page transition
  PageRoute _heroRoute() {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) =>
          const _ProfileDetailPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}

// ── Profile Detail Page (Hero destination) ───────────────────────────────────
class _ProfileDetailPage extends StatelessWidget {
  const _ProfileDetailPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6C63FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: const Text('Profile Detail'),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'profile-avatar',
              child: CircleAvatar(
                radius: 100,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 110, color: Theme.of(context).colorScheme.primary),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'John Doe',
              style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Flutter Developer · Bacolod City',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final String label;
  final String value;
  const _StatTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}
