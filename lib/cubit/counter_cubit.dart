import 'package:bloc/bloc.dart';

part 'counter_state.dart';

// Since the counter feature of the app we want to implement is really simple,
// We will start by creating a new Cubit called CounterCubit.

// So, this is mainly where Flutter understands what the press button does.
// And, this is where we should tell the Flutter's UI to a state that we
// increment or decrement the value.
//* So all we have to do is to add another boolean attribute to the CounterState class
class CounterCubit extends Cubit<CounterState> {
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
}
