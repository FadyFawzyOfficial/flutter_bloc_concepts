part of 'counter_cubit.dart';

// From here, I will start by coding an implementation that will be more
// extensive and self-explanatory instead of a quicker and abastract one.
// I'm doning this so that you can understand all the concepts really well.

// This class will be the blueprint for all possible states which will be emitted
// by the Cubit.
class CounterState {
  // Since the class must have the counter value, let's write it down and also
  // create a constructor for it.
  int counterValue;
  //* So all we have to do is to add another boolean attribute to the CounterState
  //* class called wasIncremented.
  //* This field will be true when we press the plus button and
  //* false when we press the minus button
  bool? wasIncremented;

  // The application must have a vaild counter value at all times, so every time
  // will have a new state emerging from the cubilt.
  // The counter value must be a required attribute.
  CounterState({
    required this.counterValue,
    this.wasIncremented,
  });
}
