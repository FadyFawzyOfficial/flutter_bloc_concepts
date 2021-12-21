part of 'settings_cubit.dart';

class SettingsState {
  final bool appNotification;
  final bool emailNotification;

  const SettingsState({
    required this.appNotification,
    required this.emailNotification,
  });

  SettingsState copyWith({
    bool? appNotification,
    bool? emailNotification,
  }) {
    return SettingsState(
      appNotification: appNotification ?? this.appNotification,
      emailNotification: emailNotification ?? this.emailNotification,
    );
  }
}
