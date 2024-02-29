import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:wifi_iot/wifi_iot_method_channel.dart';

abstract class WiFiForIoTPlugin extends PlatformInterface {
  WiFiForIoTPlugin() : super(token: _token);
  static final Object _token = Object();

  static WiFiForIoTPlugin _instance = MethodChannelWiFiForIot();

  /// The default instance of [WiFiForIoTPlugin] to use.
  ///
  /// Defaults to [MethodChannelWiFiForIot].
  static WiFiForIoTPlugin get instance => _instance;

  /// Returns whether the WiFi AP is enabled or not
  Future<bool> isWiFiAPEnabled() async {
    throw UnimplementedError('isWiFiAPEnabled() has not been implemented.');
  }

  /// Enable or Disable WiFi
  ///
  /// Wifi API changes for Android SDK >= 29, restricts certain behaviour:
  ///
  /// * Uses `startLocalOnlyHotspot` API to enable or disable WiFi AP.
  /// * This can only be used to communicate between co-located devices connected to the created WiFi Hotspot
  /// * The network created by this method will not have Internet access
  Future<bool> setWiFiAPEnabled(bool state) async {
    throw UnimplementedError('setWiFiAPEnabled() has not been implemented.');
  }

  /// Request write permission
  void showWritePermissionSettings(bool force) async {
    throw UnimplementedError('showWritePermissionSettings() has not been implemented.');
  }

  /// Returns whether the WiFi AP is hidden or not.
  Future<bool> isWiFiAPSSIDHidden() async {
    throw UnimplementedError('isWiFiAPSSIDHidden() has not been implemented.');
  }

  /// Set whether the WiFi AP is hidden or not
  @Deprecated("This is will only work with < Android SDK 26.")
  setWiFiAPSSIDHidden(bool hidden) async {
    throw UnimplementedError('setWiFiAPSSIDHidden() has not been implemented.');
  }

  /// Returns the WiFi AP State
  ///
  /// ```
  /// 0 = WIFI_AP_STATE_DISABLING
  /// 1 = WIFI_AP_STATE_DISABLED
  /// 2 = WIFI_AP_STATE_ENABLING
  /// 3 = WIFI_AP_STATE_ENABLED
  /// 4 = WIFI_AP_STATE_FAILED
  /// ```
  @Deprecated("This is will only work with < Android SDK 26.")
  Future<int?> getWiFiAPState() async {
    throw UnimplementedError('getWiFiAPState() has not been implemented.');
  }

  /// Get WiFi AP clients
  @Deprecated("This is will only work with < Android SDK 26.")
  Future<List<APClient>> getClientList(
      bool onlyReachables, int reachableTimeout) async {
    throw UnimplementedError('getClientList() has not been implemented.');
  }

  /// Set WiFi AP Configuaration
  @Deprecated("This is will only work with < Android SDK 26.")
  void setWiFiAPConfiguration(Object poWiFiConfig) async {
    throw UnimplementedError('setWiFiAPConfiguration() has not been implemented.');
  }

  /// Get WiFi AP SSID
  Future<String?> getWiFiAPSSID() async {
    throw UnimplementedError('getWiFiAPSSID() has not been implemented.');
  }

  /// Set WiFi AP SSID
  @Deprecated("This is will only work with < Android SDK 26.")
  setWiFiAPSSID(String psSSID) async {
    throw UnimplementedError('getWiFiAPSSID() has not been implemented.');
  }

  /// Get WiFi AP's password
  Future<String?> getWiFiAPPreSharedKey() async {
    throw UnimplementedError('getWiFiAPPreSharedKey() has not been implemented.');
  }

  /// Set WiFi AP password
  @Deprecated("This is will only work with < Android SDK 26.")
  setWiFiAPPreSharedKey(String psPreSharedKey) async {
    throw UnimplementedError('setWiFiAPPreSharedKey() has not been implemented.');
  }

  @Deprecated(
      "This is discontinued, switch to new `wifi_scan` plugin by WiFiFlutter. "
          "Check - https://pub.dev/packages/wifi_scan")
  Stream<List<WifiNetwork>>? _onWifiScanResultReady;

  @Deprecated(
      "This is discontinued, switch to new `wifi_scan` plugin by WiFiFlutter. "
          "Check - https://pub.dev/packages/wifi_scan")
  Stream<List<WifiNetwork>> get onWifiScanResultReady {
    throw UnimplementedError('onWifiScanResultReady has not been implemented.');
  }

  @Deprecated(
      "This is discontinued, switch to new `wifi_scan` plugin by WiFiFlutter. "
          "Check - https://pub.dev/packages/wifi_scan")
  Future<List<WifiNetwork>>? _loadWifiList() async {
    throw UnimplementedError('_loadWifiList() has not been implemented.');
  }

  @Deprecated(
      "This is discontinued, switch to new `wifi_scan` plugin by WiFiFlutter. "
          "Check - https://pub.dev/packages/wifi_scan")
  Future<List<WifiNetwork>> loadWifiList() async {
    throw UnimplementedError('loadWifiList() has not been implemented.');
  }

  /// Route network traffic via WiFi network.
  ///
  /// Method to force wifi usage if the user needs to send requests via wifi
  /// if it does not have internet connection. Useful for IoT applications, when
  /// the app needs to communicate and send requests to a device that have no
  /// internet connection via wifi.
  ///
  /// Receives a boolean to enable forceWifiUsage if true, and disable if false.
  ///
  /// Is important to enable only when communicating with the device via wifi
  /// and remember to disable it when disconnecting from device.
  Future<bool> forceWifiUsage(bool useWifi) async {
    throw UnimplementedError('forceWifiUsage() has not been implemented.');
  }

  /// Returns whether the WiFi is enabled
  Future<bool> isEnabled() async {
    throw UnimplementedError('isEnabled() has not been implemented.');
  }

  /// Enable or Disable WiFi
  ///
  /// @param [shouldOpenSettings] only supports on android API level >= 29
  setEnabled(bool state, {bool shouldOpenSettings = false}) async {
    throw UnimplementedError('setEnabled() has not been implemented.');
  }

  /// Connect to the requested AP Wi-Fi network.
  ///
  /// Once connected, to route network traffic via the network use
  /// [forceWifiUsage].
  ///
  /// @param [ssid] The SSID of the network to connect to.
  ///   In case multiple networks share the same SSID, which one is connected to
  ///   is undefined. Use the optional [bssid] parameters if you want to specify
  ///   the network. The SSID must be between 1 and 32 characters.
  ///
  /// @param [bssid] The BSSID (unique id) of the network to connect to.
  ///   This allows to specify exactly which network to connect to.
  // ignore: deprecated_member_use_from_same_package
  ///   To obtain the BSSID, use [loadWifiList] (Android only) or save the value
  ///   from a previous connection.
  ///   On Android, specifying the BSSID will also result in no system message
  ///   requesting permission being shown to the user.
  ///   Does nothing on iOS.
  ///
  /// @param [password] The password of the network. Should only be null in case
  ///   [security] NetworkSecurity.NONE is used.
  ///
  /// @param [security] The security type of the network. [NetworkSecurity.NONE]
  ///   means no password is required.
  ///   On Android, from version 10 (Q) onward, [NetworkSecurity.WEP] is no
  ///   longer supported.
  ///
  /// @param [joinOnce] If true, the network will be removed on exit.
  ///
  /// @param [withInternet] Whether the connected network has internet access.
  ///   Android only.
  ///
  /// @param [isHidden] Whether the SSID is hidden (not broadcasted by the AP).
  ///
  /// @returns True in case the requested network could be connected to, false
  ///   otherwise.
  Future<bool> connect(
      String ssid, {
        String? bssid,
        String? password,
        NetworkSecurity security = NetworkSecurity.NONE,
        bool joinOnce = true,
        bool withInternet = false,
        bool isHidden = false,
        int timeoutInSeconds = 30,
      }) async {
    throw UnimplementedError('connect() has not been implemented.');
  }

  /// Register a network with the system in the device's wireless networks.
  /// Android only.
  ///
  /// Once registered and connected, to route network traffic via the network
  /// use [forceWifiUsage].
  ///
  /// @param [ssid] The SSID of the network to register.
  ///   The SSID must be between 1 and 32 characters.
  ///
  /// @param [bssid] The BSSID (unique id) of the network to register.
  ///   This allows to specify exactly which network to register in case of
  ///   duplicated SSID.
  // ignore: deprecated_member_use_from_same_package
  ///   To obtain the BSSID, use [loadWifiList] (Android only) or save the value
  ///   from a previous connection.
  ///   On Android, specifying the BSSID will also result in no system message
  ///   requesting permission being shown to the user when connecting.
  ///   Does nothing on iOS.
  ///
  /// @param [password] The password of the network. Should only be null in case
  ///   [security] NetworkSecurity.NONE is used.
  ///
  /// @param [security] The security type of the network. [NetworkSecurity.NONE]
  ///   means no password is required.
  ///   On Android, from version 10 (Q) onward, [NetworkSecurity.WEP] is no
  ///   longer supported.
  ///
  /// @param [isHidden] Whether the SSID is hidden (not broadcasted by the AP).
  ///
  /// @returns True in case the requested network could be registered, false
  ///   otherwise.
  Future<bool> registerWifiNetwork(
      String ssid, {
        String? bssid,
        String? password,
        NetworkSecurity security = NetworkSecurity.NONE,
        bool isHidden = false,
      }) async {
    throw UnimplementedError('registerWifiNetwork() has not been implemented.');
  }

  /// Scan for Wi-Fi networks and connect to the requested AP Wi-Fi network if
  /// found.
  /// Android only.
  ///
  /// Once connected, to route network traffic via the network use
  /// [forceWifiUsage].
  ///
  /// @param [ssid] The SSID of the network to connect to.
  ///   In case multiple networks share the same SSID, which one is connected to
  ///   is undefined. Use the optional [bssid] parameters if you want to specify
  ///   the network. The SSID must be between 1 and 32 characters.
  ///
  /// @param [bssid] The BSSID (unique id) of the network to connect to.
  ///   This allows to specify exactly which network to connect to.
  // ignore: deprecated_member_use_from_same_package
  ///   To obtain the BSSID, use [loadWifiList] (Android only) or save the value
  ///   from a previous connection.
  ///   On Android, specifying the BSSID will also result in no system message
  ///   requesting permission being shown to the user.
  ///   Does nothing on iOS.
  ///
  /// @param [password] The password of the network. Should only be null in case
  ///   the network is not password protected.
  ///
  /// @param [joinOnce] If true, the network will be removed on exit.
  ///
  /// @param [withInternet] Whether the connected network has internet access.
  ///   Android only.
  ///
  /// @returns True in case the requested network could be connected to, false
  ///   otherwise.
  Future<bool> findAndConnect(
      String ssid, {
        String? bssid,
        String? password,
        bool joinOnce = true,
        bool withInternet = false,
        int timeoutInSeconds = 30,
      }) async {
    throw UnimplementedError('findAndConnect() has not been implemented.');
  }

  /// Returns whether the device is connected to a Wi-Fi network.
  /// Note that this does not necessarily mean that the network is accessible.
  ///
  /// @ returns True if connected to a Wi-Fi network, false otherwise.
  Future<bool> isConnected() async {
    throw UnimplementedError('isConnected() has not been implemented.');
  }

  /// Disconnect from the currently connected network.
  ///
  /// @returns True if successfully disconnected from the network.
  /// False in case of errors or if no network is currently connected.
  Future<bool> disconnect() async {
    throw UnimplementedError('disconnect() has not been implemented.');
  }

  Future<String?> getSSID() async {
    throw UnimplementedError('getSSID() has not been implemented.');
  }

  Future<String?> getBSSID() async {
    throw UnimplementedError('getBSSID() has not been implemented.');
  }

  Future<int?> getCurrentSignalStrength() async {
    throw UnimplementedError('getCurrentSignalStrength() has not been implemented.');
  }

  Future<int?> getFrequency() async {
    throw UnimplementedError('getFrequency() has not been implemented.');
  }

  Future<String?> getIP() async {
    throw UnimplementedError('getIP() has not been implemented.');
  }

  Future<bool> removeWifiNetwork(String ssid) async {
    throw UnimplementedError('removeWifiNetwork() has not been implemented.');
  }

  Future<bool> isRegisteredWifiNetwork(String ssid) async {
    throw UnimplementedError('isRegisteredWifiNetwork() has not been implemented.');
  }
}