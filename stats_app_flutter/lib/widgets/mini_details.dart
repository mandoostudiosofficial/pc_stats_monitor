import 'package:flutter/material.dart';

class MiniDetail extends StatelessWidget {
  final IconData? icon;
  final String value;
  final Color color;
  final String label;
  const MiniDetail({
    super.key,
    required this.value,
    required this.color,
    this.icon,
    this.label = '',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon == null
            ? const SizedBox()
            : Icon(icon, size: 18, color: color.withValues(alpha: 0.85)),
        const SizedBox(width: 6),
        Text(
          "$label $value",
          style: const TextStyle(
              color: Colors.white70, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
