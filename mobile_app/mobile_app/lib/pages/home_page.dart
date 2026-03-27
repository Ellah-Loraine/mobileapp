import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  // ── Implicit animation state ──────────────────────────────────────────
  double _containerSize = 100;
  Color _containerColor = const Color(0xFF6C63FF);
  double _borderRadius = 12;

  // ── Staggered animation controllers ──────────────────────────────────
  late AnimationController _staggerController;
  late List<Animation<double>> _itemAnimations;

  static const int _cardCount = 4;
  static const List<String> _cardTitles = ['Design', 'Develop', 'Deploy', 'Delight'];
  static const List<IconData> _cardIcons = [
    Icons.design_services,
    Icons.code,
    Icons.rocket_launch,
    Icons.star,
  ];
  static const List<Color> _cardColors = [
    Color(0xFF6C63FF),
    Color(0xFF43CEA2),
    Color(0xFFFF6584),
    Color(0xFFFFC947),
  ];

  @override
  void initState() {
    super.initState();

    // Staggered animation: each card fades+slides in with a delay
    _staggerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _itemAnimations = List.generate(_cardCount, (i) {
      final start = i * 0.18;
      final end = start + 0.4;
      return CurvedAnimation(
        parent: _staggerController,
        curve: Interval(start, end.clamp(0, 1), curve: Curves.easeOut),
      );
    });

    _staggerController.forward();
  }

  @override
  void dispose() {
    _staggerController.dispose();
    super.dispose();
  }

  void _toggleContainer() {
    setState(() {
      _containerSize = _containerSize == 100 ? 180 : 100;
      _containerColor = _containerColor == const Color(0xFF6C63FF)
          ? const Color(0xFFFF6584)
          : const Color(0xFF6C63FF);
      _borderRadius = _borderRadius == 12 ? 90 : 12;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Section: Implicit Animation (AnimatedContainer) ─────────────
          Text('Implicit Animation', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text('Tap the box to animate its properties (size, color, radius).', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 12),
          Center(
            child: GestureDetector(
              onTap: _toggleContainer,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                width: _containerSize,
                height: _containerSize,
                decoration: BoxDecoration(
                  color: _containerColor,
                  borderRadius: BorderRadius.circular(_borderRadius),
                  boxShadow: [
                    BoxShadow(
                      color: _containerColor.withOpacity(0.4),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    )
                  ],
                ),
                child: const Icon(Icons.touch_app, color: Colors.white, size: 32),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // ── Section: Fade Widget In and Out ──────────────────────────────
          Text('Fade Widget', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const _FadeDemo(),

          const SizedBox(height: 24),

          // ── Section: Staggered Animation ─────────────────────────────────
          Text('Staggered Animation', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _cardCount,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.3,
            ),
            itemBuilder: (context, i) {
              return FadeTransition(
                opacity: _itemAnimations[i],
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.3),
                    end: Offset.zero,
                  ).animate(_itemAnimations[i]),
                  child: Card(
                    color: _cardColors[i],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(_cardIcons[i], color: Colors.white, size: 32),
                          const SizedBox(height: 6),
                          Text(
                            _cardTitles[i],
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ── Fade in/out demo widget ───────────────────────────────────────────────────
class _FadeDemo extends StatefulWidget {
  const _FadeDemo();

  @override
  State<_FadeDemo> createState() => _FadeDemoState();
}

class _FadeDemoState extends State<_FadeDemo> {
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedOpacity(
          opacity: _visible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 600),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF43CEA2).withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF43CEA2)),
            ),
            child: const Row(
              children: [
                Icon(Icons.visibility, color: Color(0xFF43CEA2)),
                SizedBox(width: 10),
                Text('I can fade in and out!', style: TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: () => setState(() => _visible = !_visible),
          icon: Icon(_visible ? Icons.visibility_off : Icons.visibility),
          label: Text(_visible ? 'Fade Out' : 'Fade In'),
        ),
      ],
    );
  }
}
