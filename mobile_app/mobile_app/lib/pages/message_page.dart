import 'package:flutter/material.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  static const List<_Message> _messages = [
    _Message(name: 'Alice',   text: 'Hey! How are you?',       time: '9:30 AM',  unread: 3),
    _Message(name: 'Bob',     text: 'See you tomorrow!',        time: '8:15 AM',  unread: 0),
    _Message(name: 'Charlie', text: 'Did you see the update?',  time: 'Yesterday', unread: 1),
    _Message(name: 'Diana',   text: 'Flutter is amazing 🚀',   time: 'Yesterday', unread: 0),
    _Message(name: 'Eve',     text: 'Let\'s meet at 3PM',       time: 'Monday',   unread: 2),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: _messages.length,
      separatorBuilder: (_, __) => const Divider(height: 1, indent: 72),
      itemBuilder: (context, i) {
        final msg = _messages[i];
        return ListTile(
          onTap: () {
            // Navigate to chat detail with custom animated page route transition
            Navigator.of(context).push(_slideRoute(msg));
          },
          leading: CircleAvatar(
            backgroundColor: _avatarColor(i),
            child: Text(msg.name[0], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          title: Text(msg.name, style: const TextStyle(fontWeight: FontWeight.w600)),
          subtitle: Text(msg.text, maxLines: 1, overflow: TextOverflow.ellipsis),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(msg.time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              if (msg.unread > 0) ...[
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6C63FF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text('${msg.unread}', style: const TextStyle(color: Colors.white, fontSize: 11)),
                ),
              ]
            ],
          ),
        );
      },
    );
  }

  // Animated Page Route Transition (slide from right)
  PageRoute _slideRoute(_Message msg) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) =>
          _ChatDetailPage(message: msg),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween = Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
            .chain(CurveTween(curve: Curves.easeInOut));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }

  static Color _avatarColor(int i) {
    const colors = [
      Color(0xFF6C63FF),
      Color(0xFF43CEA2),
      Color(0xFFFF6584),
      Color(0xFFFFC947),
      Color(0xFF4FC3F7),
    ];
    return colors[i % colors.length];
  }
}

class _Message {
  final String name;
  final String text;
  final String time;
  final int unread;
  const _Message({required this.name, required this.text, required this.time, required this.unread});
}

// ── Chat Detail Page ──────────────────────────────────────────────────────────
class _ChatDetailPage extends StatelessWidget {
  final _Message message;
  const _ChatDetailPage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(message.name),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.chat_bubble_outline, size: 64, color: Colors.grey.shade300),
            const SizedBox(height: 12),
            Text('Chat with ${message.name}', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(
              '(Navigated with animated page route transition)',
              style: const TextStyle(color: Colors.grey, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
