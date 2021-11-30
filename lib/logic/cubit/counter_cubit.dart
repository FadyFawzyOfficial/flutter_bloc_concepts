import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../constants/enums.dart';
import 'internet_cubit.dart';

part 'counter_state.dart';

// Since the counter feature of the app we want to implement is really simple,
// We will start by creating a new Cubit called CounterCubit.

// So, this is mainly where Flutter understands what the press button does.
// And, this is where we should tell the Flutter's UI to a state that we
// increment or decrement the value.
//* So all we have to do is to add another boolean attribute to the CounterState class
class CounterCubit extends Cubit<CounterState> {
  //! Bloc Communication
  //! 1st
  //? How our well known CounterCubit can communicate with the newly created
  //? InternetCubit?
  //* Remember that our goal is that whenever the phone is connected to Wi-Fi,
  //* the Counter should increment and whenever the phone is connected to mobile,
  //* the counter should decrement.
  //! So the CounterCubit will be dependent on the InternetCubit.
  //! So we need to have a final field of Type InternetCubit ready to be
  //! initialized inside the CounterCubitt constructor as a required field.
  final InternetCubit internetCubit;
  //! 2nd
  //! Then, in order for the counter to communicate with the InternetCubit
  //! will proceed, as we did previously, by creating a StreamSubscription
  //! which will subscribe to the InternetCubit stream of states.
  //* Remember that each Bloc or Cubit has a stream of states you can subscribe to.
  late StreamSubscription internetStreamSubscription;

  // 1st: We need to set the initial state of the CounterCubit.
  // What the initial State is?  Well, it's going to be a state.
  // So we will select the CounterState class and we need to pass
  // the counterValue inside the counstructor.
  // The initial state of the counter will have the 0 value, so we will
  // set the counterValue to zero.
  CounterCubit({required this.internetCubit})
      : super(CounterState(counterValue: 0)) {
    monitorInternetCubit();
  }

  //! Architecture Tip #2:
  //! we can do the same with the counter cubitt this time we'll call it
  //! monitorInternetCubit, since according to the states emitted by it will
  //! increment or decrement our counter value.
  StreamSubscription<InternetState> monitorInternetCubit() {
    //! 3rd
    //! will subscribe to it inside CounterCubit so that whenever a new
    //! Internet state is retrieved down the stream, we can do something
    //! in response.
    return internetCubit.listen((internetState) {
      //! 4th In our case, we need to check whether the received InternetState is
      //! a type of InterneConnected and the connection type is either wifi or
      //! mobile so that we can call either the increment or decrement functions
      //! respectively.
      if (internetState is InternetConnected &&
          internetState.connectiionType == ConnectiionType.Wifi) {
        increment();
      } else if (internetState is InternetConnected &&
          internetState.connectiionType == ConnectiionType.Mobile) {
        decrement();
      }
    });
  }

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

  //! 5th
  //! Again, we need to cancel the internetStreamSubscription inside the
  //! closed method of the Cubit so that we won't listen to it forever.
  @override
  Future<void> close() {
    internetStreamSubscription.cancel();
    return super.close();
  }
}
