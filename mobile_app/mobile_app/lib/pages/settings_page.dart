import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notifications = true;
  bool _darkMode = false;
  bool _locationAccess = false;
  double _textSize = 16;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // ── Account ──────────────────────────────────────────────────────
        _sectionHeader('Account'),
        ListTile(
          leading: const Icon(Icons.person_outline),
          title: const Text('Edit Profile'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.lock_outline),
          title: const Text('Change Password'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {},
        ),

        // ── Preferences ───────────────────────────────────────────────────
        _sectionHeader('Preferences'),
        SwitchListTile(
          secondary: const Icon(Icons.notifications_outlined),
          title: const Text('Push Notifications'),
          value: _notifications,
          onChanged: (v) => setState(() => _notifications = v),
        ),
        SwitchListTile(
          secondary: const Icon(Icons.dark_mode_outlined),
          title: const Text('Dark Mode'),
          value: _darkMode,
          onChanged: (v) => setState(() => _darkMode = v),
        ),
        SwitchListTile(
          secondary: const Icon(Icons.location_on_outlined),
          title: const Text('Location Access'),
          value: _locationAccess,
          onChanged: (v) => setState(() => _locationAccess = v),
        ),

        // ── Text Size slider ──────────────────────────────────────────────
        _sectionHeader('Accessibility'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              const Icon(Icons.text_fields, size: 18),
              const SizedBox(width: 12),
              const Text('Text Size'),
              const Spacer(),
              Text('${_textSize.round()}px', style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        Slider(
          value: _textSize,
          min: 12,
          max: 24,
          divisions: 6,
          label: '${_textSize.round()}px',
          onChanged: (v) => setState(() => _textSize = v),
        ),

        // ── About ──────────────────────────────────────────────────────────
        _sectionHeader('About'),
        ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text('App Version'),
          trailing: const Text('1.0.0', style: TextStyle(color: Colors.grey)),
        ),
        ListTile(
          leading: const Icon(Icons.logout, color: Colors.red),
          title: const Text('Sign Out', style: TextStyle(color: Colors.red)),
          onTap: () {},
        ),
      ],
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
