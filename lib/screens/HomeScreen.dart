import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:dole/screens/AlertsScreen.dart';
import 'package:dole/screens/InsolePairingScreen.dart';
import 'package:dole/screens/SettingsScreen.dart';
import 'package:dole/model/screenModel.dart' as Model;

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
  int _currentIndex = 0;
  final List<Widget> _screens = [];
  
  List<FlSpot> _temperatureSpots = [];

  @override
  void initState() {
    super.initState();
    _connectToDevice();
    
    _temperatureSpots = [
      FlSpot(0, 1),
      FlSpot(1, 3),
      FlSpot(2, 10),
      // Add more FlSpot instances as needed
    ];
  }

  void _connectToDevice() {
    BluetoothConnection.toAddress('00:24:01:00:0C:76').then((connection) {
      connection.input?.listen((data) {
        final readings = String.fromCharCodes(data).split(',');
        if (readings.length == 3) {
          setState(() {
            temperatureValue = double.tryParse(readings[0]) ?? 0.0;
            humidityValue = double.tryParse(readings[1]) ?? 0.0;
            pressureValue = double.tryParse(readings[2]) ?? 0.0;
            _screens.clear();
            _screens.addAll([
              NewHomeContent(
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
            ]);
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
        child: _screens.isNotEmpty ? _screens[_currentIndex] : const CircularProgressIndicator(),
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

class NewHomeContent extends StatelessWidget {
  final double temperature;
  final double humidity;
  final double pressure;

  const NewHomeContent({
    Key? key,
    required this.temperature,
    required this.humidity,
    required this.pressure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sensor Readings',
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0),
                  Text('Temperature: ${temperature.toStringAsFixed(2)}'),
                  Text('Humidity: ${humidity.toStringAsFixed(2)}'),
                  Text('Pressure: ${pressure.toStringAsFixed(2)}'),
                ],
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Health Status',
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0),
                  Text('Temperature: ${FunctionalityModel.categorizeTemperature(temperature)}'),
                  Text('Humidity: ${FunctionalityModel.categorizeHumidity(humidity)}'),
                  Text('Pressure: ${FunctionalityModel.categorizePressure(pressure)}'),
                ],
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Statistics',
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0),
                  SizedBox(
                    height: 200.0,
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(show: false),
                        titlesData: FlTitlesData(show: false),
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            spots: _temperatureSpots,
                            isCurved: true,
                            barWidth: 3,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
