import 'package:flutter/material.dart';
import 'package:pc_stats_monitor/widgets/mini_details.dart';
import 'package:pc_stats_monitor/widgets/speed_gauge.dart';
import '../constants/app_colors.dart';
import 'load_gauge.dart';

class CoreCard extends StatelessWidget {
  final String title;
  final Color accentColor;
  final double loadValue;
  final double tempValue;
  final double clockValue;
  final double wattValue;
  final double? vramValue;
  final double? cpuVcore;
  final double? vrmMosTemp;
  final double? vrmSocTemp;
  final double? gpuHotSpotTemp;
  final double? gpuGpuJuctionTemp;
  final double? gpuFan1Percentage;
  final double? gpuFan2Percentage;
  final double? gpuFan1Rpm;
  final double? gpuFan2Rpm;

  const CoreCard({
    super.key,
    required this.title,
    required this.accentColor,
    required this.loadValue,
    required this.tempValue,
    required this.clockValue,
    required this.wattValue,
    this.vramValue,
    this.cpuVcore,
    this.vrmMosTemp,
    this.vrmSocTemp,
    this.gpuHotSpotTemp,
    this.gpuGpuJuctionTemp,
    this.gpuFan1Percentage,
    this.gpuFan2Percentage,
    this.gpuFan1Rpm,
    this.gpuFan2Rpm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(22),
        border:
            Border.all(color: accentColor.withValues(alpha: 0.25), width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: accentColor,
              fontSize: 18,
              fontWeight: FontWeight.w900,
              letterSpacing: 3,
            ),
          ),
          Expanded(
            child: Center(
              child: LoadGauge(
                loadValue: loadValue,
                tempValue: tempValue,
                color: accentColor,
              ),
            ),
          ),
          FittedBox(
            fit: BoxFit.contain,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (vrmMosTemp != null)
                  MiniDetail(
                      label: 'VRM',
                      value: '${vrmMosTemp!.toStringAsFixed(0)}°C',
                      color: accentColor),
                if (vrmSocTemp != null)
                  MiniDetail(
                      label: 'SOC',
                      value: '${vrmSocTemp!.toStringAsFixed(0)}°C',
                      color: accentColor),
                if (cpuVcore != null)
                  MiniDetail(
                      icon: Icons.electric_bolt,
                      value: '${cpuVcore!.toStringAsFixed(3)}V',
                      color: accentColor),
              ],
            ),
          ),
          FittedBox(
              fit: BoxFit.contain,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (gpuFan1Percentage != null && gpuFan1Rpm != null)
                      SizedBox(
                        height: 75,
                        child: SpeedGauge(
                          rpmPercentage: gpuFan1Percentage,
                          rpmValue: gpuFan1Rpm!,
                          maxRpm: 2200,
                          color: accentColor,
                        ),
                      ),
                    const SizedBox(width: 2),
                    if (gpuFan2Percentage != null && gpuFan2Rpm != null)
                      SizedBox(
                        height: 75,
                        child: SpeedGauge(
                          rpmPercentage: gpuFan2Percentage,
                          rpmValue: gpuFan2Rpm!,
                          maxRpm: 2200,
                          color: accentColor,
                        ),
                      ),
                  ])),
          FittedBox(
            fit: BoxFit.contain,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (gpuGpuJuctionTemp != null)
                  MiniDetail(
                      label: 'Junc',
                      value: '${gpuGpuJuctionTemp!.toStringAsFixed(0)}°C',
                      color: accentColor),
                if (gpuHotSpotTemp != null)
                  MiniDetail(
                      label: 'HotS.',
                      value: '${gpuHotSpotTemp!.toStringAsFixed(0)}°C',
                      color: accentColor),
              ],
            ),
          ),
          if (vramValue != null)
            MiniDetail(
                icon: Icons.memory,
                value: 'VRAM ${(vramValue! / 1024).toStringAsFixed(1)} GB',
                color: accentColor),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MiniDetail(
                  icon: Icons.speed,
                  value: '${clockValue.toStringAsFixed(0)} MHz',
                  color: accentColor),
              MiniDetail(
                  icon: Icons.bolt,
                  value: '${wattValue.toStringAsFixed(0)} W',
                  color: accentColor),
            ],
          ),
        ],
      ),
    );
  }
}
