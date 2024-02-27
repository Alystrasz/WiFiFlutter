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
    return Future.value(_client.connectivityCheckAvailable && !_client.startup ? CanStartScan.yes : CanStartScan.failed);
  }

  @override
  Future<bool> startScan() {
    // Retrieve Wi-Fi network interface
    // TODO which interface to use if there are many?
    // TODO find a better way to find Wi-Fi interface
    _device = _client.devices.firstWhere((element) => element.interface.substring(0, 2) == "wl");
    return Future.value(true);
  }
}