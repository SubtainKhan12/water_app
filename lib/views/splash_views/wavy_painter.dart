import 'package:flutter/material.dart';
import 'dart:math' as math;

class WavePainter extends CustomPainter {
  final double waveValue;

  WavePainter(this.waveValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader =
          LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              const Color(0xFF00B4D8).withValues(alpha: 0.1),
              const Color(0xFF0077B6).withValues(alpha: 0.3),
            ],
          ).createShader(
            Rect.fromPoints(
              Offset(0, size.height * 0.6),
              Offset(size.width, size.height),
            ),
          )
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.7);

    // Create wave points
    for (double i = 0; i <= size.width; i += 10) {
      final y =
          size.height * 0.7 +
          sin(i * 0.02 + waveValue * 2 * 3.14) * 20 +
          pow(i / size.width, 2) * size.height * 0.3;
      path.lineTo(i, y);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Helper function for sine calculation
double sin(double x) => math.sin(x);
double pow(double x, double exponent) => math.pow(x, exponent).toDouble();
