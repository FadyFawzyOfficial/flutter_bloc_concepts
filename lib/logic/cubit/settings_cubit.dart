import 'package:bloc/bloc.dart';

part 'settings_state.dart';

// To manage Settings Screen, we have to create SettingsCubit which will emit
// a single SettingsState each time 1 of the tiles are toggled.
class SettingsCubit extends Cubit<SettingsState> {
  //! The initialState of the Cubit will be SettingsState with both of their
  //! field sets to false.
  SettingsCubit()
      : super(
          SettingsState(
            appNotification: false,
            emailNotification: false,
          ),
        );

  //! YOU SHOULD NEVER MUTATE EXISTING STATES!!
  //! The mistakes some of the users of Bloc Library make while coding that lead
  //! to the state not being updated anymore.
  void toggleAppNotification(bool newValue) {
    //! Some People may do the following:
    //! They will take the current state, which is the SettingState, modify its
    //! appNotification value directly to the new value, subsequently emitting
    //! that state again into the stream of emitted states.
    //! These two lines of code are really, really, really wrong and must be
    //! avoided at all costs.
    //! First of all, we're mutating an existing state of our Cubit.
    //! This is a complete violation of the main principle of Bloc.
    //* Remember, for every interaction user makes with UI, there should be a
    //* new state emitted from the Bloc or Cubit.
    //! So you should never but never modify or mutate any already existing state
    //! from inside a Bloc or Cubit.
    //! You can access its value using the state operator like 'state.value',
    //! but you should never modify it.

    //! The biggest problem isn't, however, this line of code, but rather the next one.
    state.appNotification = newValue;

    //! Bloc won't consecutively emit 2 identical states.
    //! It may seem that if you modify the appNotification value above with the
    //! new value, the state we're missing here will be different from the
    //! previous one. This is again WRONG.
    //* Remember that compares objects.
    //* Currently this emitted state is to dart the same exact state as it was before.
    //* Doesn't matter if we modified its value here is just like we compare 2
    //* same objects it will still return True, since it's the same object to
    //* the previous state being equal to one you're trying to emit.
    //! DART KNOWS THIS state IS THE SAME AS THE PREVIOUS EMITTED ONE!!
    //* Bloc Library won't emit a new state to the stream of states,
    //* therefore not updating the UI.
    emit(state);

    // emit(state.copyWith(appNotification: newValue));
  }

  //! This function will be triggered when the Email Notification Tile is pressed.
  void toggleEmailNotification(bool newValue) =>
      emit(state.copyWith(emailNotification: newValue));
}
