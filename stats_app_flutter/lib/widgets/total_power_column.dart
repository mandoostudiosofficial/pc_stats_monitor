import 'package:flutter/material.dart';
import 'package:pc_stats_monitor/widgets/ram_gauge.dart';
import 'package:pc_stats_monitor/widgets/speed_gauge.dart';
import '../constants/app_colors.dart';

class TotalPowerColumn extends StatelessWidget {
  final double totalWatt;
  final double ramUsage;
  final double ramUsedGb;
  final double ramTotalGb;
  final double cpuFanSpeed;
  final double cpuPumpFanSpeed;
  final double cpuOptFanSpeed;

  const TotalPowerColumn({
    super.key,
    required this.totalWatt,
    required this.ramUsage,
    required this.ramUsedGb,
    required this.ramTotalGb,
    required this.cpuFanSpeed,
    required this.cpuPumpFanSpeed,
    required this.cpuOptFanSpeed,
  });

  @override
  Widget build(BuildContext context) {
    const accent = AppColors.powerAccent;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: accent.withValues(alpha: 0.25), width: 1),
      ),
      child: Column(
        spacing: 4,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  totalWatt.toStringAsFixed(0),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    shadows: [
                      Shadow(
                        color: accent.withValues(alpha: 0.8),
                        blurRadius: 18,
                      ),
                    ],
                  ),
                ),
                const Text(
                  'TOTAL WATT',
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: RamGauge(
              ramUsage: ramUsage,
              ramUsedGb: ramUsedGb,
              ramTotalGb: ramTotalGb,
              color: AppColors.ramAccent,
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              spacing: 2,
              children: [
                Expanded(
                  child: SpeedGauge(
                      rpmValue: cpuFanSpeed, maxRpm: 2200, color: accent),
                ),
                Expanded(
                  child: SpeedGauge(
                      rpmValue: cpuPumpFanSpeed, maxRpm: 4500, color: accent),
                ),
                Expanded(
                  child: SpeedGauge(
                      rpmValue: cpuOptFanSpeed, maxRpm: 2200, color: accent),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
