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
    final fans = <Widget>[
      if (gpuFan1Percentage != null && gpuFan1Rpm != null)
        Expanded(
          child: SpeedGauge(
            rpmPercentage: gpuFan1Percentage,
            rpmValue: gpuFan1Rpm!,
            maxRpm: 2200,
            color: accentColor,
          ),
        ),
      if (gpuFan2Percentage != null && gpuFan2Rpm != null)
        Expanded(
          child: SpeedGauge(
            rpmPercentage: gpuFan2Percentage,
            rpmValue: gpuFan2Rpm!,
            maxRpm: 2200,
            color: accentColor,
          ),
        ),
    ];

    final hasVrmRow =
        vrmMosTemp != null || vrmSocTemp != null || cpuVcore != null;
    final hasTempRow = gpuGpuJuctionTemp != null || gpuHotSpotTemp != null;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(22),
        border:
            Border.all(color: accentColor.withValues(alpha: 0.25), width: 1),
      ),
      child: Column(
        spacing: 4,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              style: TextStyle(
                color: accentColor,
                fontSize: 16,
                fontWeight: FontWeight.w900,
                letterSpacing: 3,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: LoadGauge(
              loadValue: loadValue,
              tempValue: tempValue,
              color: accentColor,
            ),
          ),
          if (hasVrmRow)
            _MiniRow(children: [
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
            ]),
          if (fans.isNotEmpty)
            Expanded(
              flex: 2,
              child: Row(spacing: 4, children: fans),
            ),
          if (hasTempRow)
            _MiniRow(children: [
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
            ]),
          if (vramValue != null)
            _MiniRow(children: [
              MiniDetail(
                  icon: Icons.memory,
                  value: 'VRAM ${(vramValue! / 1024).toStringAsFixed(1)} GB',
                  color: accentColor),
            ]),
          _MiniRow(children: [
            MiniDetail(
                icon: Icons.speed,
                value: '${clockValue.toStringAsFixed(0)} MHz',
                color: accentColor),
            MiniDetail(
                icon: Icons.bolt,
                value: '${wattValue.toStringAsFixed(0)} W',
                color: accentColor),
          ]),
        ],
      ),
    );
  }
}

class _MiniRow extends StatelessWidget {
  final List<Widget> children;
  const _MiniRow({required this.children});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 10,
        children: children,
      ),
    );
  }
}
