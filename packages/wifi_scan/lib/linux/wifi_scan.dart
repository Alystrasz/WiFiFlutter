import 'dart:convert';

import 'package:wifi_scan/wifi_scan.dart';
import 'package:nm/nm.dart';

class WifiScanPlugin extends WifiScanPlatform {
  late NetworkManagerClient _client;
  late NetworkManagerDevice _device;

  WifiScanPlugin() {
    _client = NetworkManagerClient();
    _client.connect();
  }

  static void registerWith() {
    WifiScanPlatform.instance = WifiScanPlugin();
  }

  @override
  Future<CanStartScan> canStartScan({bool askPermissions = true}) {
    if (!_client.wirelessEnabled || !_client.wirelessHardwareEnabled) {
      return Future.value(CanStartScan.noLocationServiceDisabled);
    }
    return Future.value(_client.connectivityCheckAvailable && !_client.startup
        ? CanStartScan.yes
        : CanStartScan.failed);
  }

  @override
  Future<bool> startScan() {
    // Retrieve Wi-Fi network interface
    // TODO which interface to use if there are many?
    // TODO find a better way to find Wi-Fi interface
    _device = _client.devices
        .firstWhere((element) => element.interface.substring(0, 2) == "wl");
    return Future.value(true);
  }

  @override
  Future<CanGetScannedResults> canGetScannedResults(
      {bool askPermissions = true}) {
    // TODO: implement canGetScannedResults
    return Future.value(CanGetScannedResults.yes);
  }

  @override
  Future<List<WiFiAccessPoint>> getScannedResults() {
    List<WiFiAccessPoint> aps = _device.wireless!.accessPoints
        .map((ap) => WiFiAccessPoint.fromMap({
              "ssid": utf8.decode(ap.ssid),
              "bssid": ap.hwAddress,
              "capabilities": "",
              "frequency": ap.frequency,
              "level": ap.strength,
              "timestamp": ap.lastSeen,
              "channelWidth": ap.maxBitrate,
            }))
        .toList();
    return Future.value(aps);
  }
}
