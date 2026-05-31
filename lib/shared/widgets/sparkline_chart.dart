import 'package:flutter/material.dart';

import 'sparkline_painter.dart';

class SparklineChart extends StatelessWidget {
  final Color color;
  final List<double> points;

  const SparklineChart({super.key, required this.color, required this.points});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SparklinePainter(color: color, points: points),
      child: const SizedBox.expand(),
    );
  }
}
