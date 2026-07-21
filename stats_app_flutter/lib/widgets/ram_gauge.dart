import 'dart:math' show pi;
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class RamGauge extends StatelessWidget {
  final double ramUsage;
  final double ramUsedGb;
  final double ramTotalGb;
  final Color color;

  const RamGauge({
    super.key,
    required this.ramUsage,
    required this.ramUsedGb,
    required this.ramTotalGb,
    required this.color,
  });

  static const double _baseSize = 200;

  @override
  Widget build(BuildContext context) {
    final fraction = (ramUsage / 100).clamp(0.0, 1.0);

    return Center(
      child: FittedBox(
        fit: BoxFit.contain,
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: fraction),
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutCubic,
          builder: (context, animatedFraction, child) {
            return SizedBox(
              width: _baseSize,
              height: _baseSize,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: _baseSize,
                    height: _baseSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: color.withValues(alpha: 0.30),
                          blurRadius: 32,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                  CustomPaint(
                    size: const Size(_baseSize, _baseSize),
                    painter: _ArcGaugePainter(
                      fraction: animatedFraction,
                      color: color,
                      trackColor: AppColors.trackBackground,
                      strokeWidth: _baseSize * 0.10,
                      sweepDegrees: 270,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${ramUsage.toStringAsFixed(0)}%',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: _baseSize * 0.20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        'RAM',
                        style: TextStyle(
                          color: Colors.white38,
                          fontWeight: FontWeight.w600,
                          fontSize: _baseSize * 0.06,
                          letterSpacing: 1.5,
                        ),
                      ),
                      SizedBox(height: _baseSize * 0.045),
                      Text(
                        '${ramUsedGb.toStringAsFixed(1)} / ${ramTotalGb.toStringAsFixed(1)} GB',
                        style: TextStyle(
                          color: color,
                          fontSize: _baseSize * 0.10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ArcGaugePainter extends CustomPainter {
  final double fraction;
  final Color color;
  final Color trackColor;
  final double strokeWidth;
  final double sweepDegrees;

  _ArcGaugePainter({
    required this.fraction,
    required this.color,
    required this.trackColor,
    required this.strokeWidth,
    this.sweepDegrees = 270,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );

    final gapDegrees = 360 - sweepDegrees;
    final startDegrees = 90 + gapDegrees / 2;
    final startAngle = startDegrees * pi / 180;
    final totalSweepAngle = sweepDegrees * pi / 180;

    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(rect, startAngle, totalSweepAngle, false, trackPaint);

    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      rect,
      startAngle,
      totalSweepAngle * fraction.clamp(0.0, 1.0),
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _ArcGaugePainter oldDelegate) {
    return oldDelegate.fraction != fraction || oldDelegate.color != color;
  }
}
