import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_colors.dart';
import '../models/pc_stats_dto.dart';
import '../viewmodels/hardware_monitor_screen_mixin.dart';
import '../widgets/bar_dashboard.dart';
import '../widgets/connection_status_bar.dart';
import '../widgets/core_card.dart';
import '../widgets/total_power_column.dart';

class HardwareMonitorScreen extends StatefulWidget {
  const HardwareMonitorScreen({super.key});

  @override
  State<HardwareMonitorScreen> createState() => _HardwareMonitorScreenState();
}

class _HardwareMonitorScreenState extends State<HardwareMonitorScreen>
    with WidgetsBindingObserver, HardwareMonitorScreenMixin {
  bool _barTheme = false;

  @override
  void initState() {
    super.initState();
    initViewModel();
  }

  @override
  void dispose() {
    disposeViewModel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    }
  }

  void _toggleTheme() {
    HapticFeedback.mediumImpact();
    setState(() => _barTheme = !_barTheme);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onLongPress: _toggleTheme,
        child: SafeArea(
          child: _barTheme ? _buildBarTheme() : _buildGaugeTheme(),
        ),
      ),
    );
  }

  Widget _buildBarTheme() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 6, 10, 8),
      child: ValueListenableBuilder<bool>(
        valueListenable: connectionNotifier,
        builder: (context, connected, _) {
          return ValueListenableBuilder<PcStatsDto>(
            valueListenable: statsNotifier,
            builder: (context, stats, _) =>
                BarDashboard(stats: stats, connected: connected),
          );
        },
      ),
    );
  }

  Widget _buildGaugeTheme() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 6, 12, 8),
      child: Column(
        children: [
          ValueListenableBuilder<bool>(
            valueListenable: connectionNotifier,
            builder: (context, isConnected, child) {
              return ConnectionStatusBar(connected: isConnected);
            },
          ),
          const SizedBox(height: 6),
          Expanded(
            child: ValueListenableBuilder<PcStatsDto>(
              valueListenable: statsNotifier,
              builder: (context, stats, child) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 8,
                  children: [
                    Expanded(
                      child: CoreCard(
                        title: 'CPU',
                        cpuVcore: stats.cpuVcore,
                        accentColor: AppColors.cpuAccent,
                        loadValue: stats.cpuLoad,
                        tempValue: stats.cpuTemp,
                        clockValue: stats.cpuClock,
                        wattValue: stats.cpuWatt,
                        vrmMosTemp: stats.vrmMosTemp,
                        vrmSocTemp: stats.vrmSocTemp,
                      ),
                    ),
                    Expanded(
                      child: TotalPowerColumn(
                        cpuFanSpeed: stats.cpuFanSpeed,
                        cpuOptFanSpeed: stats.cpuOptFanSpeed,
                        cpuPumpFanSpeed: stats.cpuPumpFanSpeed,
                        totalWatt: stats.totalWatt,
                        ramUsage: stats.ramUsage,
                        ramUsedGb: stats.ramUsedGb,
                        ramTotalGb: stats.ramTotalGb,
                      ),
                    ),
                    Expanded(
                      child: CoreCard(
                        title: 'GPU',
                        accentColor: AppColors.gpuAccent,
                        loadValue: stats.gpuLoad,
                        tempValue: stats.gpuTemp,
                        clockValue: stats.gpuClock,
                        wattValue: stats.gpuWatt,
                        vramValue: stats.gpuVramUsedMb,
                        gpuHotSpotTemp: stats.gpuHotSpotTemp,
                        gpuGpuJuctionTemp: stats.gpuGpuJuctionTemp,
                        gpuFan1Percentage: stats.gpuFan1Percentage,
                        gpuFan2Percentage: stats.gpuFan2Percentage,
                        gpuFan1Rpm: stats.gpuFan1Rpm,
                        gpuFan2Rpm: stats.gpuFan2Rpm,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
