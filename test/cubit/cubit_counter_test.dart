import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc_concepts/cubit/counter_cubit.dart';

// So inside the test file we need to start by creating a main function.
void main() {
  // Inside this main function, will go right ahead and create a 'group' with
  // the with the name of CounterCubit.
  //* A 'group' is actaully a way of organizing multiple tests for a feature.
  // So, For example, inside our CounterCubit group will write all the
  // neccessary tests for the counter fearure.
  //* In a group, you can also share a common setup and tear down
  //* functions across all the available tests.
  group('CounterCubit: ', () {
    late CounterCubit counterCubit;

    //! 1st:
    //? What is a purpose of these functions?
    //* Inside a setUp function you can instantiate the objects our test will
    //* be working with.
    // In our case, we will instantiate the CounterBloc so that we can access
    // it later on in our tests.
    setUp(() {
      //* So 'setUp' is mainly as its name is implying, a function which will
      //* be called to create and initialize the necessary data this will
      //* work with.
      counterCubit = CounterCubit();
    });

    //! 3rd:
    // Now the time has finally come for us to write our first test, which is
    // going to be checking if the initial state of our CounterCubit is equal
    // to the CounterState with a counter value of 0.
    //* We are going to do this by creating a test function and give it a
    //* description which would be denote the porpuse of it.
    test(
        'The initial state for the CounterCubit is CounterState(counterValue: 0)',
        () {
      //? How do we check this?
      //* The porpuse of any test is to double check that the output of the
      //* feature is actually equal to the excpected output and nothing else.
      //! featureOutput == excepectedOutput
      //* To do this, all we need is the expect function, which will take 2 main
      //* important arguments, the actual value return by our initial state and
      //* the expected value which we are expecting to be received.
      // So our initial state returned when Cubit is created, will be
      // counterCubit.state & the expected value should be CounterState()
      // which has a counterValue equal to 0;
      //! If we run this test, we will surprisingly receive a complete failure
      expect(counterCubit.state, CounterState(counterValue: 0));
    });

    //! 2nd:
    // On the other hand, the treadown function is a function that will called
    // after each test is run.
    // If it is called within a group, it will apply, of coures, only to the
    // test in that group.
    tearDown(() {
      // Inside of these, perhaps we can close the created Cubit.
      counterCubit.close();
    });
  });
}
