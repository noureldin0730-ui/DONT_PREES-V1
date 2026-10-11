import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/map_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const DontPressApp());
}

class DontPressApp extends StatelessWidget {
  const DontPressApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "DON'T PRESS",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF050505),
      ),
      home: const StartScreen(),
    );
  }
}

// ═══════════════ الألوان ═══════════════
class P {
  static const bg = Color(0xFF050505);
  static const dim = Color(0xFF6A6A6A);
  static const mid = Color(0xFFAA3333);
  static const rare = Color(0xFFFF4444);
  static const white = Color(0xFFE0E0E0);
  static const gold = Color(0xFFFFCC44);
}

// ═══════════════ شاشة البداية ═══════════════
class StartScreen extends StatefulWidget {
  const StartScreen({super.key});
  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulse;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  void _start() {
    HapticFeedback.mediumImpact();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const MapScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: P.bg,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              FadeTransition(
                opacity: Tween<double>(begin: 0.55, end: 1.0).animate(_pulse),
                child: const Text(
                  "DON'T PRESS",
                  style: TextStyle(
                    color: P.rare,
                    fontSize: 36,
                    letterSpacing: 8,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(height: 80),
              GestureDetector(
                onTap: _start,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 60,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: P.mid, width: 2),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: P.mid.withOpacity(0.4),
                        blurRadius: 30,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: const Text(
                    'Start',
                    style: TextStyle(
                      color: P.white,
                      fontSize: 24,
                      letterSpacing: 4,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              const Padding(
                padding: EdgeInsets.only(bottom: 24),
                child: Text(
                  'Nour Developer',
                  style: TextStyle(
                    color: P.dim,
                    fontSize: 14,
                    letterSpacing: 3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}