import 'dart:convert';

import 'package:wifi_scan/wifi_scan.dart';
import 'package:nm/nm.dart';

/// Linux implementation of the wifi_scan plugin.
/// This relies on the NetworkManager client package from Canonical
/// (https://pub.dev/packages/nm).
class WifiScanPlugin extends WiFiScan {
  late NetworkManagerClient _client;
  late NetworkManagerDevice _device;

  /// This constructor instantiates a NetworkManager client to be used in
  /// future method calls; the client is straight up connected after
  /// instantiation, for it to be ready for Wi-Fi scanning operations.
  WifiScanPlugin() {
    _client = NetworkManagerClient();
    _client.connect();
  }

  /// Registers this plugin to be used within Linux applications.
  static void registerWith() {
    WiFiScan.instance = WifiScanPlugin();
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
              "level": (ap.strength/100 * (-30 - -120) - 120).toInt(),
              "timestamp": ap.lastSeen,
              "channelWidth": ap.maxBitrate,
            }))
        .toList();
    return Future.value(aps);
  }
}
