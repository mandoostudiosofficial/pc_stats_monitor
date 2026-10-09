class PcStatsDto {
  final double cpuLoad;
  final double cpuTemp;
  final double cpuClock;
  final double cpuWatt;
  final double cpuVcore;
  final double cpuFanSpeed;
  final double cpuOptFanSpeed;
  final double cpuPumpFanSpeed;
  final double gpuLoad;
  final double gpuTemp;
  final double gpuClock;
  final double gpuWatt;
  final double gpuVramUsedMb;
  final double ramUsage;
  final double ramUsedGb;
  final double ramTotalGb;
  final double totalWatt;
  final double vrmMosTemp;
  final double vrmSocTemp;
  final double gpuHotSpotTemp;
  final double gpuGpuJuctionTemp;
  final double gpuFan1Percentage;
  final double gpuFan2Percentage;
  final double gpuFan1Rpm;
  final double gpuFan2Rpm;

  const PcStatsDto({
    this.cpuLoad = 0,
    this.cpuTemp = 0,
    this.cpuClock = 0,
    this.cpuWatt = 0,
    this.cpuVcore = 0,
    this.cpuFanSpeed = 0,
    this.cpuOptFanSpeed = 0,
    this.cpuPumpFanSpeed = 0,
    this.gpuLoad = 0,
    this.gpuTemp = 0,
    this.gpuClock = 0,
    this.gpuWatt = 0,
    this.gpuVramUsedMb = 0,
    this.ramUsage = 0,
    this.ramUsedGb = 0,
    this.ramTotalGb = 0,
    this.totalWatt = 0,
    this.vrmMosTemp = 0,
    this.vrmSocTemp = 0,
    this.gpuHotSpotTemp = 0,
    this.gpuGpuJuctionTemp = 0,
    this.gpuFan1Percentage = 0,
    this.gpuFan2Percentage = 0,
    this.gpuFan1Rpm = 0,
    this.gpuFan2Rpm = 0,
  });

  factory PcStatsDto.fromJson(Map<String, dynamic> json) {
    return PcStatsDto(
      cpuLoad: _toDouble(json['CpuLoad']),
      cpuTemp: _toDouble(json['CpuTemp']),
      cpuClock: _toDouble(json['CpuClock']),
      cpuWatt: _toDouble(json['CpuWatt']),
      cpuVcore: _toDouble(json['CpuVcore']),
      cpuFanSpeed: _toDouble(json['CpuFanRpm']),
      cpuOptFanSpeed: _toDouble(json['CpuOptFanRpm']),
      cpuPumpFanSpeed: _toDouble(json['CpuPumpRpm']),
      gpuLoad: _toDouble(json['GpuLoad']),
      gpuTemp: _toDouble(json['GpuTemp']),
      gpuClock: _toDouble(json['GpuClock']),
      gpuWatt: _toDouble(json['GpuWatt']),
      gpuVramUsedMb: _toDouble(json['GpuVramUsedMb']),
      ramUsage: _toDouble(json['RamUsage']),
      ramUsedGb: _toDouble(json['RamUsedGb']),
      ramTotalGb: _toDouble(json['RamTotalGb']),
      totalWatt: _toDouble(json['TotalWatt']),
      vrmMosTemp: _toDouble(json['VrmMosTemp']),
      vrmSocTemp: _toDouble(json['VrmSocTemp']),
      gpuHotSpotTemp: _toDouble(json['GpuHotspotTemp']),
      gpuGpuJuctionTemp: _toDouble(json['GpuJunctionTemp']),
      gpuFan1Percentage: _toDouble(json['GpuFan1Percentage']),
      gpuFan2Percentage: _toDouble(json['GpuFan2Percentage']),
      gpuFan1Rpm: _toDouble(json['GpuFan1Rpm']),
      gpuFan2Rpm: _toDouble(json['GpuFan2Rpm']),
    );
  }

  static double _toDouble(dynamic v) {
    if (v == null) return 0;
    if (v is num) return v.toDouble();
    return double.tryParse(v.toString()) ?? 0;
  }
}
