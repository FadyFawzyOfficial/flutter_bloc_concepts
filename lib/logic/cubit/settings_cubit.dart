import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_state.dart';

// To manage Settings Screen, we have to create SettingsCubit which will emit
// a single SettingsState each time 1 of the tiles are toggled.
class SettingsCubit extends Cubit<SettingsState> {
  //! The initialState of the Cubit will be SettingsState with both of their
  //! field sets to false.
  SettingsCubit()
      : super(
          const SettingsState(
            appNotification: false,
            emailNotification: false,
          ),
        );

  // This function will be triggered when the App Notification Tile is pressed.
  void toggleAppNotification(bool newValue) {
    //! In order to fix this issue: StateNotUpdating
    //! We need to erase these 2 lines of code
    // state.appNotification = newValue;
    // emit(state);
    //! copuyWith
    //* Here we can emit a new state (new instance of SettingsState)
    //* by calling state.copyWith which will crate a new SettingsState and copy
    //* the content from the previous one to the new state by also setting up
    //* the newValue of appNotification
    emit(state.copyWith(appNotification: newValue));
  }

  // This function will be triggered when the Email Notification Tile is pressed.
  void toggleEmailNotification(bool newValue) =>
      emit(state.copyWith(emailNotification: newValue));
}
