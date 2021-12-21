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
  //! please pay attention while working with equatable package and with how
  //! Dart compares objects in general.
  @override
  List<Object?> get props => [appNotification, emailNotification];
}
