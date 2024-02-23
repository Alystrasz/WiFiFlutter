import 'package:wifi_scan/wifi_scan.dart';

class WifiScanPlugin extends WifiScanPlatform {
  static void registerWith() {
    WifiScanPlatform.instance = WifiScanPlugin();
  }

  @override
  Future<CanStartScan> canStartScan({bool askPermissions = true}) {
    print("TODO");
    return super.canStartScan(askPermissions: askPermissions);
  }
}