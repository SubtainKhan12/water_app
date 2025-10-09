import 'package:flutter/material.dart';
import 'package:water_app/views/splash_views/wavy_painter.dart';
import '../auth_views/login_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _waveAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    _waveAnimation = Tween<double>(begin: -0.1, end: 0.1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.repeat(reverse: true);

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Animated wave background
          AnimatedBuilder(
            animation: _waveAnimation,
            builder: (context, child) {
              return CustomPaint(
                size: Size(MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height),
                painter: WavePainter(_waveAnimation.value),
              );
            },
          ),

          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF90E0EF),
                        Color(0xFF0077B6),
                      ],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.shade100,
                        blurRadius: 15,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.waves,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Hydrate',
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0077B6),
                    fontFamily: 'Poppins',
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Your Daily Water Tracker',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF00B4D8),
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


