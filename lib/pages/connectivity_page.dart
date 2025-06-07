import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:battery_plus/battery_plus.dart';

class ConnectivityPage extends StatefulWidget {
  const ConnectivityPage({super.key});

  @override
  State<ConnectivityPage> createState() => _ConnectivityPageState();
}

class _ConnectivityPageState extends State<ConnectivityPage> {
  String _connectionStatus = 'Checking...';

  final Battery _battery = Battery(); // plugin instance
  int _batteryLevel = -1; // battery level placeholder

  // battery icon depending on level
  IconData getBatteryIcon(int batteryLevel) {
    if (batteryLevel >= 90) {
      return Icons.battery_full;
    } else if (batteryLevel >= 75) {
      return Icons.battery_6_bar;
    } else if (batteryLevel >= 50) {
      return Icons.battery_5_bar;
    } else if (batteryLevel >= 30) {
      return Icons.battery_3_bar;
    } else if (batteryLevel >= 10) {
      return Icons.battery_1_bar;
    } else {
      return Icons.battery_alert;
    }
  }

  // _connectivity is the plugin object used to check internet status and listen for changes
  final Connectivity _connectivity = Connectivity();

  @override
  void initState() {
    super.initState();
    // _checkInitialConnection() asks for current connection once and updates the UI
    _checkInitialConnection();

    // get battery status after loading
    _getBatteryLevel();

    // the listener onConnectivityChanged.listen is a stream that waits for connection changes and notifies you
    _connectivity.onConnectivityChanged.listen((results) {
      _updateConnectionStatus(
        // the listener gets a list called results, then you pick the first item or none if empty, and call _updateConnectionStatus() with it
        results.isNotEmpty ? results.first : ConnectivityResult.none,
      );
    });
  }

  // function calls checkConnectivity(), which returns a future resolving to the current connection status
  Future<void> _checkInitialConnection() async {
    final results = await _connectivity.checkConnectivity();
    print('checkConnectivity() returned: $results');
    _updateConnectionStatus(
      // code expects a list here and picks the first element
      results.isNotEmpty ? results.first : ConnectivityResult.none,
    );
  }

  // function to get battery level
  Future<void> _getBatteryLevel() async {
    final level = await _battery.batteryLevel;
    setState(() {
      _batteryLevel = level;
    });
  }

  // updates your _connectionStatus string based on the connectivity enum value
  void _updateConnectionStatus(ConnectivityResult result) {
    // calls setState() so the UI refreshes with the new status
    setState(() {
      // switch covers common cases (wifi, mobile, none) and a fallback
      switch (result) {
        case ConnectivityResult.wifi:
          _connectionStatus = 'Connected to Wi-Fi';
          break;
        case ConnectivityResult.mobile:
          _connectionStatus = 'Connected to Mobile Network';
          break;
        case ConnectivityResult.none:
          _connectionStatus = 'No Internet Connection';
          break;
        default:
          _connectionStatus = 'Unknown Connection';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // wifi info
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: colorScheme.inversePrimary, width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Icon(
                    _connectionStatus.contains('No')
                        ? Icons.signal_wifi_off
                        : Icons.wifi,
                    size: 80,
                    color: colorScheme.inversePrimary,
                  ),
                  SizedBox(height: 20),
                  Text(
                    _connectionStatus,
                    style: TextStyle(
                      fontSize: 22,
                      color: colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: _checkInitialConnection,
              icon: Icon(Icons.refresh),
              label: Text('Check Again'),
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.inversePrimary,
                foregroundColor: colorScheme.primary,
              ),
            ),

            // battery info
            SizedBox(height: 25),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: colorScheme.inversePrimary, width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Icon(
                    getBatteryIcon(_batteryLevel),
                    size: 48,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  SizedBox(height: 10),
                  Text(
                    _batteryLevel == -1
                        ? ' Checking Battery...'
                        : ' Battery Level: $_batteryLevel%',
                    style: TextStyle(
                      fontSize: 18,
                      color: colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
