import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class SparklinePainter extends CustomPainter {
  final Color color;
  final List<double> points;

  const SparklinePainter({required this.color, required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length < 2 || size.width <= 0 || size.height <= 0) {
      return;
    }

    final minValue = points.reduce((a, b) {
      if (a < b) {
        return a;
      }

      return b;
    });
    final maxValue = points.reduce((a, b) {
      if (a > b) {
        return a;
      }

      return b;
    });
    final range = maxValue - minValue == 0 ? 1.0 : maxValue - minValue;
    final path = Path();

    for (var index = 0; index < points.length; index++) {
      final x = size.width * index / (points.length - 1);
      final normalized = (points[index] - minValue) / range;
      final y = size.height - normalized * size.height;

      if (index == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    final fillPath = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0.0, size.height)
      ..close();
    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          color.withValues(alpha: 0.22),
          AppColors.chartFill.withValues(alpha: 0.0),
        ],
      ).createShader(Offset.zero & size);
    final linePaint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant SparklinePainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.points != points;
  }
}
