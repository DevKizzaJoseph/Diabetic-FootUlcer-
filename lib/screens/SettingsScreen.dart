import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20.0),
            // Directly use ListView without Flexible
            ListView(
              shrinkWrap: true, // Allows ListView to size itself according to its children
              physics: NeverScrollableScrollPhysics(), // Disables scrolling within ListView
              children: <Widget>[
                buildSettingsItem('Notifications', context),
                buildSettingsItem('Share Data', context, onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DownloadDataScreen()),
                  );
                }),
                buildSettingsItem('Account Management', context),
              ],
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Implement logout logic here
              },
              child: const Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSettingsItem(String title, BuildContext context, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: Text(
          title,
          style: const TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}

class DownloadDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Download Data'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Implement your data download logic here
            // For example, generating and sharing a CSV file
          },
          child: Text('Download My Data in CSV'),
        ),
      ),
    );
  }
}