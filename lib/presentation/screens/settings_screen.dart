import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubit/settings_cubit.dart';

// Settings Screen containing 2 SwitchListTile: App Notification & Email Notification.
class SettingsScreen extends StatelessWidget {
  static const name = '/settings';

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.grey[700],
      ),
      //! We have also added a BlocListener to show a SnackBar to see the values.
      body: BlocListener<SettingsCubit, SettingsState>(
        listener: (context, state) {
          final notificationSnackBar = SnackBar(
            duration: const Duration(milliseconds: 500),
            content: Text(
                'App ${state.appNotification.toString().toUpperCase()}, '
                'Email ${state.emailNotification.toString().toUpperCase()}'),
          );

          Scaffold.of(context).showSnackBar(notificationSnackBar);
        },
        //! We use BlocBuilder in order to rebuild the SwithListTile according
        //! to the specific values found inside the SettingsState
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return Column(
              children: [
                SwitchListTile(
                  title: const Text('App Notifications'),
                  value: state.appNotification,
                  onChanged:
                      context.read<SettingsCubit>().toggleAppNotification,
                ),
                SwitchListTile(
                  title: const Text('Email Notifications'),
                  value: state.emailNotification,
                  onChanged:
                      context.read<SettingsCubit>().toggleEmailNotification,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
