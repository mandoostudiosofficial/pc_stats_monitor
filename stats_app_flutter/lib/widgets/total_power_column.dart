import 'package:flutter/material.dart';
import 'package:pc_stats_monitor/widgets/ram_gauge.dart';
import 'package:pc_stats_monitor/widgets/speed_gauge.dart';
import '../constants/app_colors.dart';

class TotalPowerColumn extends StatelessWidget {
  final double totalWatt;
  final double ramUsage;
  final double ramUsedGb;
  final double ramTotalGb;
  final double? cpuVcore;
  final double? cpuFanSpeed;
  final double? cpuOptFanSpeed;
  final Color accentColor = AppColors.powerAccent;

  const TotalPowerColumn({
    super.key,
    required this.totalWatt,
    required this.ramUsage,
    required this.ramUsedGb,
    required this.ramTotalGb,
    this.cpuVcore,
    this.cpuFanSpeed,
    this.cpuOptFanSpeed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
            color: AppColors.powerAccent.withValues(alpha: 0.25), width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
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
                      color: AppColors.powerAccent.withValues(alpha: 0.8),
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
          const Spacer(
            flex: 1,
          ),
          Expanded(
              flex: 20,
              child: RamGauge(
                ramUsage: ramUsage,
                ramUsedGb: ramUsedGb,
                ramTotalGb: ramTotalGb,
                color: AppColors.ramAccent,
              )),
          Expanded(
            flex: 14,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //  if (cpuVcore != null)
                  //  MiniDetail(
                  //      icon: Icons.electric_bolt,
                  //      value: 'Vcore ${(cpuVcore!).toStringAsFixed(1)} V',
                  //      color: accentColor),
                  //      if (cpuFanSpeed != null)
                  if (cpuVcore != null)
                    // MiniDetail(
                    //     icon: Icons.electric_bolt,
                    //     value: 'Vcore ${(cpuVcore!).toStringAsFixed(1)} V',
                    //     color: accentColor),
                    //     if (cpuFanSpeed != null)
                    SpeedGauge(
                      rpmValue: cpuFanSpeed!,
                      maxRpm: 2200,
                      color: accentColor,
                    ),
                  SpeedGauge(
                    rpmValue: cpuOptFanSpeed!,
                    maxRpm: 2200,
                    color: accentColor,
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
