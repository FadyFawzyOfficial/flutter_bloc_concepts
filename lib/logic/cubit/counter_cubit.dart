import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'counter_state.dart';

// Since the counter feature of the app we want to implement is really simple,
// We will start by creating a new Cubit called CounterCubit.

// So, this is mainly where Flutter understands what the press button does.
// And, this is where we should tell the Flutter's UI to a state that we
// increment or decrement the value.
//* So all we have to do is to add another boolean attribute to the CounterState class

//! Hydrated Bloc
//* For Bloc/Cubit to become Hydrated that is for the setup Bloc or Cubit to save
//* and retrieve from the storage, we need to use the HydratedMixin
class CounterCubit extends Cubit<CounterState> with HydratedMixin {
  //! Bloc Communication
  //! Bloc Listener
  //! So definitely the most important advantage of BlocListener over
  //! StreamSubscription is the fact that we don't need to create or manage
  //! the StreamSubscriptions manually.
  //! So that's we refactor the code and delete the subscriptions from inside
  //! the CounterCubit we don't even need the InternetCubit dependancy anymore
  //! since we'll just listen to it by using BlocListener inside the widget tree.
  //! So the CounterCubit class will actually be having just its plain
  //! functionality in there.

  // 1st: We need to set the initial state of the CounterCubit.
  // What the initial State is?  Well, it's going to be a state.
  // So we will select the CounterState class and we need to pass
  // the counterValue inside the counstructor.
  // The initial state of the counter will have the 0 value, so we will
  // set the counterValue to zero.
  CounterCubit() : super(CounterState(counterValue: 0));

  // 2nd: All we have to do is implement the increment and decrement functions
  // which will emit new counter states (CounterState).

  // So the increment function will emit a new counter state (CoutnerState) with
  // a new counter value (counterValue) passed into its constructor.
  // A counter value (counterValue) which is going to be equal to the current
  // counter value + 1.
  // You can access the current state of a cubit by using the 'state' keyword
  // this will return an instance of the current state of our counter.
  //* Modify the incremental and decremental function accordingly
  void increment() => emit(
        CounterState(
          counterValue: state.counterValue + 1,
          wasIncremented: true,
        ),
      );

  // the same procedure (as increment function) applies to the decrement function.
  // The only difference being that instead of adding 1 will subtract 1 from the
  // current state value.
  void decrement() => emit(
        CounterState(
          counterValue: state.counterValue - 1,
          wasIncremented: false,
        ),
      );

  //! These 2 methods are the pillars of Storing and Saving the States to
  //! to the Storage while also being able to retrieving back when the app
  //! is rebooted. and all we have to do is implement these functions.

  //* CALLED EVERY TIME THE APP NEEDS STORED DATA
  // This function 'fromJson' is called every time the app needs the local stored data.
  @override
  CounterState? fromJson(Map<String, dynamic> json) {
    //* When we want the app to access the last saved data from the local storage
    //* HydratedBloc will call fromJson function and retrieve the json which is
    //* already converted into a map.
    //! We need to return a new instance of the CounterState populated with the
    //! data from that map.
    return CounterState.fromMap(json);
  }

  //* CALLED FOR EVERY STATE
  // This function toJson is called for every emitted state by the (Counter) Cubit.
  @override
  Map<String, dynamic>? toJson(CounterState state) {
    //* So every time there is a new CounterState emitted with a new CounterValue
    //* we want to save its data to a map and then send it to HydratedBloc to
    //* Store it into the Local Storage.
    return state.toMap();
  }

  //! Debugging Bloc
  // This function takes a change instance of type counter state parameter.
  // So every time a new state is emitted down the stream of states,
  // this function will be called with a Change instance containing both the
  // current and the next state.
  // Obviously, this will help you track and debug the stream of emitted states,
  // which is really important.
  @override
  void onChange(Change<CounterState> change) {
    //* You may adopt two approaches.
    //* You can either manually code what you want to be printed by accessing
    //* both counts values of the current and previous state.
    // print('current: ${change.currentState.counterValue} '
    //     'next: ${change.nextState.counterValue}');
    //* Or you can opt for a much faster and efficient approach.
    //* You can simply print the past change instance as a parameter to the
    //* onChange function.
    //? But how does Dart know how to print an instance of the CounterState,
    //? you may ask?
    //! Well, at the moment it doesn't.
    //! But if we go to the CounterState class, we can override the toString function,
    //! which is mainly called when Dart wants a string representation of the
    //! object instantiated from the CounterState class.
    print(change);
    super.onChange(change);
  }
}
