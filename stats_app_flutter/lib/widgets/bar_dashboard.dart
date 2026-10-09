import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/pc_stats_dto.dart';

class BarDashboard extends StatelessWidget {
  final PcStatsDto stats;
  final bool connected;

  const BarDashboard({
    super.key,
    required this.stats,
    required this.connected,
  });

  // Bar tavan değerleri: kendi donanımına göre ayarla.
  static const double _cpuMaxWatt = 140;
  static const double _cpuMaxClock = 4850;
  static const double _cpuMaxVcore = 1.45;
  static const double _gpuMaxWatt = 370;
  static const double _gpuMaxClock = 2100;
  static const double _vramTotalMb = 10240;
  static const double _maxTemp = 100;
  static const double _maxJunctionTemp = 110;
  static const double _maxSocTemp = 80;
  static const double _maxMosTemp = 80;
  static const double _maxHotSpotTemp = 95;
  static const double _cpuFanMaxRpm = 2200;
  static const double _pumpMaxRpm = 4500;

  static double _f(double v, double max) => (v / max).clamp(0.0, 1.0);

  @override
  Widget build(BuildContext context) {
    final s = stats;

    return Column(
      spacing: 6,
      children: [
        SizedBox(
          height: 30,
          child: _Header(connected: connected, totalWatt: s.totalWatt),
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 8,
            children: [
              Expanded(
                child: _Panel(
                  title: 'CPU',
                  color: AppColors.cpuAccent,
                  rows: [
                    _BarRow(
                        label: 'LOAD',
                        value: '${s.cpuLoad.toStringAsFixed(0)}%',
                        fraction: _f(s.cpuLoad, 100),
                        color: AppColors.cpuAccent,
                        alertAbove: 0.9),
                    _BarRow(
                        label: 'TEMP',
                        value: '${s.cpuTemp.toStringAsFixed(0)}°C',
                        fraction: _f(s.cpuTemp, _maxTemp),
                        color: AppColors.cpuAccent,
                        alertAbove: 0.85),
                    _BarRow(
                        label: 'POWER',
                        value: '${s.cpuWatt.toStringAsFixed(0)} W',
                        fraction: _f(s.cpuWatt, _cpuMaxWatt),
                        color: AppColors.cpuAccent),
                    _BarRow(
                        label: 'CLOCK',
                        value: '${s.cpuClock.toStringAsFixed(0)} MHz',
                        fraction: _f(s.cpuClock, _cpuMaxClock),
                        color: AppColors.activeGreen,
                        alertAbove: 0.96),
                    _BarRow(
                        label: 'VCORE',
                        value: '${s.cpuVcore.toStringAsFixed(3)} V',
                        fraction: _f(s.cpuVcore, _cpuMaxVcore),
                        color: AppColors.cpuAccent),
                    _BarRow(
                        label: 'VRM',
                        value: '${s.vrmMosTemp.toStringAsFixed(0)}°C',
                        fraction: _f(s.vrmMosTemp, _maxMosTemp),
                        color: AppColors.cpuAccent,
                        alertAbove: 0.85),
                    _BarRow(
                        label: 'SOC',
                        value: '${s.vrmSocTemp.toStringAsFixed(0)}°C',
                        fraction: _f(s.vrmSocTemp, _maxSocTemp),
                        color: AppColors.cpuAccent,
                        alertAbove: 0.85),
                  ],
                ),
              ),
              Expanded(
                child: _Panel(
                  title: 'GPU',
                  color: AppColors.gpuAccent,
                  rows: [
                    _BarRow(
                        label: 'LOAD',
                        value: '${s.gpuLoad.toStringAsFixed(0)}%',
                        fraction: _f(s.gpuLoad, 100),
                        color: AppColors.gpuAccent,
                        alertAbove: 0.95),
                    _BarRow(
                        label: 'TEMP',
                        value: '${s.gpuTemp.toStringAsFixed(0)}°C',
                        fraction: _f(s.gpuTemp, _maxTemp),
                        color: AppColors.gpuAccent,
                        alertAbove: 0.85),
                    _BarRow(
                        label: 'HOTSPOT',
                        value: '${s.gpuHotSpotTemp.toStringAsFixed(0)}°C',
                        fraction: _f(s.gpuHotSpotTemp, _maxHotSpotTemp),
                        color: AppColors.gpuAccent,
                        alertAbove: 0.85),
                    _BarRow(
                        label: 'JUNC',
                        value: '${s.gpuGpuJuctionTemp.toStringAsFixed(0)}°C',
                        fraction: _f(s.gpuGpuJuctionTemp, _maxJunctionTemp),
                        color: AppColors.gpuAccent,
                        alertAbove: 0.85),
                    _BarRow(
                        label: 'POWER',
                        value: '${s.gpuWatt.toStringAsFixed(0)} W',
                        fraction: _f(s.gpuWatt, _gpuMaxWatt),
                        color: AppColors.gpuAccent,
                        alertAbove: 0.95),
                    _BarRow(
                        label: 'CLOCK',
                        value: '${s.gpuClock.toStringAsFixed(0)} MHz',
                        fraction: _f(s.gpuClock, _gpuMaxClock),
                        color: AppColors.gpuAccent),
                    _BarRow(
                        label: 'VRAM',
                        value:
                            '${(s.gpuVramUsedMb / 1024).toStringAsFixed(1)} GB',
                        fraction: _f(s.gpuVramUsedMb, _vramTotalMb),
                        color: AppColors.gpuAccent,
                        alertAbove: 0.95),
                  ],
                ),
              ),
              Expanded(
                child: _Panel(
                  title: 'SYSTEM',
                  color: AppColors.powerAccent,
                  rows: [
                    _BarRow(
                        label: 'RAM',
                        value:
                            '${s.ramUsedGb.toStringAsFixed(1)}/${s.ramTotalGb.toStringAsFixed(0)} GB',
                        fraction: _f(s.ramUsage, 100),
                        color: AppColors.ramAccent,
                        alertAbove: 0.9),
                    _BarRow(
                        label: 'CPU FAN',
                        value: '${s.cpuFanSpeed.toStringAsFixed(0)} RPM',
                        fraction: _f(s.cpuFanSpeed, _cpuFanMaxRpm),
                        color: AppColors.powerAccent),
                    _BarRow(
                        label: 'PUMP',
                        value: '${s.cpuPumpFanSpeed.toStringAsFixed(0)} RPM',
                        fraction: _f(s.cpuPumpFanSpeed, _pumpMaxRpm),
                        color: AppColors.powerAccent),
                    _BarRow(
                        label: 'OPT FAN',
                        value: '${s.cpuOptFanSpeed.toStringAsFixed(0)} RPM',
                        fraction: _f(s.cpuOptFanSpeed, _cpuFanMaxRpm),
                        color: AppColors.powerAccent),
                    _BarRow(
                        label: 'GPU F1',
                        value: '${s.gpuFan1Rpm.toStringAsFixed(0)} RPM',
                        fraction: _f(s.gpuFan1Percentage, 100),
                        color: AppColors.gpuAccent),
                    _BarRow(
                        label: 'GPU F2',
                        value: '${s.gpuFan2Rpm.toStringAsFixed(0)} RPM',
                        fraction: _f(s.gpuFan2Percentage, 100),
                        color: AppColors.gpuAccent),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final bool connected;
  final double totalWatt;

  const _Header({required this.connected, required this.totalWatt});

  @override
  Widget build(BuildContext context) {
    final statusColor =
        connected ? AppColors.activeGreen : AppColors.inactiveRed;

    return Row(
      spacing: 8,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(shape: BoxShape.circle, color: statusColor),
        ),
        Text(
          connected ? 'LINK ACTIVE' : 'WAITING FOR PC',
          style: TextStyle(
            color: statusColor,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 2,
            fontFamily: 'monospace',
          ),
        ),
        const Spacer(),
        const Text(
          'TOTAL',
          style: TextStyle(
            color: Colors.white38,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 2,
            fontFamily: 'monospace',
          ),
        ),
        Text(
          '${totalWatt.toStringAsFixed(0)} W',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w800,
            fontFamily: 'monospace',
            shadows: [
              Shadow(
                color: AppColors.powerAccent.withValues(alpha: 0.8),
                blurRadius: 14,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Panel extends StatelessWidget {
  final String title;
  final Color color;
  final List<Widget> rows;

  const _Panel({
    required this.title,
    required this.color,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.30), width: 1),
      ),
      child: Column(
        spacing: 4,
        children: [
          Row(
            spacing: 6,
            children: [
              Container(width: 4, height: 14, color: color),
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 3,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              children: [for (final r in rows) Expanded(child: r)],
            ),
          ),
        ],
      ),
    );
  }
}

class _BarRow extends StatelessWidget {
  final String label;
  final String value;
  final double fraction;
  final Color color;
  final double? alertAbove;

  const _BarRow({
    required this.label,
    required this.value,
    required this.fraction,
    required this.color,
    this.alertAbove,
  });

  @override
  Widget build(BuildContext context) {
    final alert = alertAbove != null && fraction >= alertAbove!;
    final barColor = alert ? AppColors.inactiveRed : color;

    return Row(
      spacing: 6,
      children: [
        Expanded(
          flex: 3,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white38,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: fraction),
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutCubic,
            builder: (context, v, _) => _Bar(fraction: v, color: barColor),
          ),
        ),
        Expanded(
          flex: 4,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerRight,
            child: Text(
              value,
              style: TextStyle(
                color: alert ? AppColors.inactiveRed : Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Bar extends StatelessWidget {
  final double fraction;
  final Color color;

  const _Bar({required this.fraction, required this.color});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(3),
      child: SizedBox(
        height: 8,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(color: AppColors.trackBackground),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: fraction.clamp(0.0, 1.0),
                  heightFactor: 1,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [color.withValues(alpha: 0.45), color],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
