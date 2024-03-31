import 'package:flutter/material.dart';
import 'package:dole/screens/HomeScreen.dart'; // Ensure this import is correct

class AlertsScreen extends StatelessWidget {
  final double temperature;
  final double humidity;
  final double pressure;

  AlertsScreen({
    required Key key,
    required this.temperature,
    required this.humidity,
    required this.pressure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Generate a list of alerts based on the sensor readings
    List<Widget> alerts = _generateAlerts();

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: alerts,
        ),
      ),
    );
  }

  List<Widget> _generateAlerts() {
    List<Widget> alerts = [];

    // Temperature Alert
    String temperatureAlert = temperature > FunctionalityModel.highTempThreshold
        ? "Temperature is above threshold. Keep the foot cool and avoid tight footwear."
        : "Temperature is below threshold. Keep the foot warm and avoid exposure to cold.";
    alerts.add(_buildAlertWidget('Temperature', temperatureAlert, temperature > FunctionalityModel.highTempThreshold ? Colors.red : Colors.blue));

    // Humidity Alert
    String humidityAlert = humidity > FunctionalityModel.highHumidityThreshold
        ? "Humidity is above threshold. Keep the foot dry and use moisture-absorbing socks."
        : "Humidity is below threshold. Keep the foot moisturized.";
    alerts.add(_buildAlertWidget('Humidity', humidityAlert, humidity > FunctionalityModel.highHumidityThreshold ? Colors.red : Colors.blue));

    // Pressure Alert
    String pressureAlert = pressure > FunctionalityModel.highPressureThreshold
        ? "Pressure is above threshold. Ensure proper foot support and frequent position changes."
        : "Pressure is below threshold. Ensure good foot support.";
    alerts.add(_buildAlertWidget('Pressure', pressureAlert, pressure > FunctionalityModel.highPressureThreshold ? Colors.red : Colors.blue));

    return alerts;
  }

  Widget _buildAlertWidget(String type, String message, Color color) {
    return ListTile(
      leading: Icon(Icons.warning, color: color),
      title: Text('$type Alert', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: color)),
      subtitle: Text(message, style: TextStyle(fontSize: 16.0)),
    );
  }
}