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

  Map<String, dynamic> toMap() {
    return {
      'appNotification': appNotification,
      'emailNotification': emailNotification,
    };
  }

  factory SettingsState.fromMap(Map<String, dynamic> map) {
    return SettingsState(
      appNotification: map['appNotification'] ?? false,
      emailNotification: map['emailNotification'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory SettingsState.fromJson(String source) =>
      SettingsState.fromMap(json.decode(source));

  @override
  String toString() =>
      'SettingsState(appNotification: $appNotification, emailNotification: $emailNotification)';
}
