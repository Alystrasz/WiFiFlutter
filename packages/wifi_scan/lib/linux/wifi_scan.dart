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
    print("TODO");
    return super.canStartScan(askPermissions: askPermissions);
  }
}