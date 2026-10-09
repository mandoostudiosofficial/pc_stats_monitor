import 'package:flutter/material.dart';

class MiniDetail extends StatelessWidget {
  final IconData? icon;
  final String value;
  final Color color;
  final String label;
  final double fontSize;

  const MiniDetail({
    super.key,
    required this.value,
    required this.color,
    this.icon,
    this.label = '',
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    final text = label.isEmpty ? value : '$label $value';
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 4,
      children: [
        if (icon != null)
          Icon(icon, size: fontSize + 2, color: color.withValues(alpha: 0.85)),
        Text(
          text,
          style: TextStyle(
            color: Colors.white70,
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
