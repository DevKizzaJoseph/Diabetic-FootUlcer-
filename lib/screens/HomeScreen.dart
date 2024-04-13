import 'package:dole/screens/AlertsScreen.dart';
import 'package:dole/screens/InsolePairingScreen.dart';
import 'package:dole/screens/SettingsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class FunctionalityModel {
  static const double lowTempThreshold = 18.0;
  static const double highTempThreshold = 28.0;
  static const double lowHumidityThreshold = 30.0;
  static const double highHumidityThreshold = 70.0;
  static const double lowPressureThreshold = 80000.0;
  static const double highPressureThreshold = 120000.0;

  static String categorizeTemperature(double temp) {
    if (temp < lowTempThreshold) {
      return 'Low';
    } else if (temp <= highTempThreshold) {
      return 'Optimal';
    } else {
      return 'High';
    }
  }

  static String categorizeHumidity(double humidity) {
    if (humidity < lowHumidityThreshold) {
      return 'Low Relative';
    } else if (humidity <= highHumidityThreshold) {
      return 'Optimal Relative';
    } else {
      return 'High Relative';
    }
  }

  static String categorizePressure(double pressure) {
    if (pressure < lowPressureThreshold) {
      return 'Low';
    } else if (pressure <= highPressureThreshold) {
      return 'Moderate';
    } else {
      return 'High';
    }
  }
}

class HomeScreen extends StatefulWidget {
  final int currentIndex;

  const HomeScreen({Key? key, this.currentIndex = 0}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double temperatureValue = 0.0;
  double humidityValue = 0.0;
  double pressureValue = 0.0;
  bool isConnected = false;
  int _currentIndex = 0;
  List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeContent(
        temperature: temperatureValue,
        humidity: humidityValue,
        pressure: pressureValue,
      ),
      AlertsScreen(
        key: UniqueKey(),
        temperature: temperatureValue,
        humidity: humidityValue,
        pressure: pressureValue,
      ),
      InsolePairingScreen(),
      SettingsScreen(),
    ];
    _connectToDevice();
  }

  void _connectToDevice() {
    BluetoothConnection.toAddress('00:24:01:00:0C:76').then((connection) {
      connection.input?.listen((data) {
        final readings = String.fromCharCodes(data).split(',');
        if (readings.length == 3) {
          setState(() {
            isConnected = true;
            temperatureValue = double.tryParse(readings[0]) ?? 0.0;
            humidityValue = double.tryParse(readings[1]) ?? 0.0;
            pressureValue = double.tryParse(readings[2]) ?? 0.0;
            _screens = [
              HomeContent(
                temperature: temperatureValue,
                humidity: humidityValue,
                pressure: pressureValue,
              ),
              AlertsScreen(
                key: UniqueKey(),
                temperature: temperatureValue,
                humidity: humidityValue,
                pressure: pressureValue,
              ),
              InsolePairingScreen(),
              SettingsScreen(),
            ];
          });
        }
      }).onError((error) {
        print("Error: $error");
      });
    }).catchError((error) {
      print("Connection failed: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DoLe Insole', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color.fromARGB(255, 108, 179, 237),
      ),
      body: Center(
        child: isConnected ? _screens[_currentIndex] : HomeContent(
          temperature: temperatureValue,
          humidity: humidityValue,
          pressure: pressureValue,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Alerts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bluetooth),
            label: 'Insole Pairing',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  final double temperature;
  final double humidity;
  final double pressure;

  const HomeContent({
    Key? key,
    required this.temperature,
    required this.humidity,
    required this.pressure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  final temperatureCategory = FunctionalityModel.categorizeTemperature(temperature);
  final humidityCategory = FunctionalityModel.categorizeHumidity(humidity);
  final pressureCategory = FunctionalityModel.categorizePressure(pressure);

  return Padding(
    padding: const EdgeInsets.only(top: 20.0), // Adjust the value as needed
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sensor Readings',
                  style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10.0),
                Text('Temperature: ${temperature.toStringAsFixed(2)} °C', style: const TextStyle(fontSize: 18.0)),
                Text('Humidity: ${humidity.toStringAsFixed(2)} %', style: const TextStyle(fontSize: 18.0)),
                Text('Pressure: ${pressure.toStringAsFixed(2)} Pa', style: const TextStyle(fontSize: 18.0)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20.0),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Health Status',
                  style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10.0),
                Text('Pressure: $pressureCategory', style: const TextStyle(fontSize: 18.0)),
                Text('Temperature: $temperatureCategory', style: const TextStyle(fontSize: 18.0)),
                Text('Humidity: $humidityCategory', style: const TextStyle(fontSize: 18.0)),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
}
  
