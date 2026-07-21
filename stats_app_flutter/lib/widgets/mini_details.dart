import 'package:flutter/material.dart';

class MiniDetail extends StatelessWidget {
  final IconData icon;
  final String value;
  final Color color;

  const MiniDetail(
      {super.key,
      required this.icon,
      required this.value,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: color.withValues(alpha: 0.85)),
        const SizedBox(width: 6),
        Text(
          value,
          style: const TextStyle(
              color: Colors.white70, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
