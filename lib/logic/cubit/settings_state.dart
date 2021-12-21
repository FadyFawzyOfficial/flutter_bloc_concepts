part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final bool appNotification;
  final bool emailNotification;

  const SettingsState({
    required this.appNotification,
    required this.emailNotification,
  });

  //* copyWith method creates a new instance of a class (SettingsState) by
  //* copying the entire previous one and then inside its prameters, you can
  //* mention which field you want to modify after it gets created.
  SettingsState copyWith({
    bool? appNotification,
    bool? emailNotification,
  }) {
    return SettingsState(
      appNotification: appNotification ?? this.appNotification,
      emailNotification: emailNotification ?? this.emailNotification,
    );
  }

  //! DON'T FORGET TO MENTION YOUR CORRECT PROPS VARIABLES!!
  //! Another mistake users do use that whenever they use the equatable package,
  //! they forget to place the values inside the props (method) variablea.
  //! In our case, if we were to do that, we would have set our SettingsState
  //! to extend equatable. Then let's say we forgot to write the appNotifications
  //! variable inside the props. This means that DART will only compare 2
  //! SettingsState by checking only the values of emailNotifications variables.
  //! So, for example, if only the appNotification variable modifies,
  //! Dart won't care about it and will still return 'true' while comparing the
  //! two states.
  //* So if we save & run this project and click the SwitchListTile for
  //* the App Notification feature, it won't do anything since Dart thinks
  //* it's the same state as before and won't emitted it.

  @override
  List<Object?> get props => [emailNotification];
}
