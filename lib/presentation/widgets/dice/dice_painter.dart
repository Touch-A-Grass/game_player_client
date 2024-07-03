import 'dart:math';

import 'package:flutter/material.dart';

class DicePainter extends CustomPainter {
  final int value;
  final int maxValue;
  final double scrollProgress;
  final double fadeProgress;
  final double fadeInProgress;
  final Color color;
  final List<String> values;

  DicePainter({
    required this.value,
    required this.maxValue,
    required this.scrollProgress,
    required this.fadeProgress,
    required this.color,
    required this.values,
    required this.fadeInProgress,
  });

  static const shellCount = 40;
  static const shellWidth = 100;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(fadeInProgress)
      ..style = PaintingStyle.stroke;

    final extraPaint = Paint()
      ..color = color.withOpacity(min(fadeProgress, fadeInProgress))
      ..style = PaintingStyle.stroke;

    if (values.length < shellCount) {
      return;
    }
    for (int i = 0; i < shellCount; i++) {
      final correct = i == 25;
      final span = TextSpan(
          style: TextStyle(
            color: correct ? paint.color : extraPaint.color,
            fontSize: 20,
          ),
          text: values[i]);
      final textPainter = TextPainter(text: span, textDirection: TextDirection.ltr);

      textPainter.layout();

      final xOffset = i * shellWidth - scrollProgress * shellWidth * 25 + size.width / 2 - textPainter.width / 2;

      textPainter.paint(
        canvas,
        Offset(xOffset, size.height / 2 - textPainter.height / 2),
      );

      canvas.drawLine(
        Offset(xOffset + shellWidth / 2 + textPainter.width / 2, 0),
        Offset(xOffset + shellWidth / 2 + textPainter.width / 2, size.height),
        extraPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant DicePainter oldDelegate) {
    return value != oldDelegate.value ||
        maxValue != oldDelegate.maxValue ||
        scrollProgress != oldDelegate.scrollProgress ||
        fadeProgress != oldDelegate.fadeProgress ||
        color != oldDelegate.color;
  }
}
