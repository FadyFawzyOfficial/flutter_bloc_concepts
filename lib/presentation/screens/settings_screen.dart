import 'package:flutter/material.dart';

// Settings Screen containing 2 SwitchListTile: App Notification & Email Notification.
class SettingsScreen extends StatefulWidget {
  static const name = '/settings';

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var appNotification = false;
  var emailNotification = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.grey[700],
      ),
      body: Column(
        children: [
          SwitchListTile(
            value: appNotification,
            onChanged: (value) {
              setState(() {
                appNotification = value;
              });
            },
            title: const Text('App Notifications'),
          ),
          SwitchListTile(
            value: emailNotification,
            onChanged: (value) {
              setState(() {
                emailNotification = value;
              });
            },
            title: const Text('Email Notifications'),
          ),
        ],
      ),
    );
  }
}
