import 'package:wifi_scan/wifi_scan.dart';
import 'package:nm/nm.dart';

class WifiScanPlugin extends WifiScanPlatform {
  late NetworkManagerClient _client;

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
    return Future.value(_client.connectivityCheckAvailable && !_client.startup ? CanStartScan.yes : CanStartScan.failed);
  }
}