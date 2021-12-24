part of 'counter_cubit.dart';

// From here, I will start by coding an implementation that will be more
// extensive and self-explanatory instead of a quicker and abastract one.
// I'm doning this so that you can understand all the concepts really well.

// This class will be the blueprint for all possible states which will be emitted
// by the Cubit.
//* After adding the Equtable package to pubspec.yaml file.
//* We need to extend the CounerState class with it.
class CounterState extends Equatable {
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

  // We need to override the props of the equatable class.
  //* The props are just a way of indicating equatable, which are the fields in
  //* our class that we want to be compared while applying the equal operator.
  //* So we are goint to pass both the counterValue & wasIncremented attribute
  //* inside the props list
  @override
  List<Object?> get props => [counterValue, wasIncremented];

  Map<String, dynamic> toMap() {
    return {
      'counterValue': counterValue,
      'wasIncremented': wasIncremented,
    };
  }

  factory CounterState.fromMap(Map<String, dynamic> map) {
    return CounterState(
      counterValue: map['counterValue']?.toInt() ?? 0,
      wasIncremented: map['wasIncremented'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CounterState.fromJson(String source) =>
      CounterState.fromMap(json.decode(source));

  @override
  String toString() =>
      'CounterState(counterValue: $counterValue, wasIncremented: $wasIncremented)';
}
