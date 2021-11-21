import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/cubit/counter_cubit.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/second_sreen.dart';
import 'presentation/screens/third_screen.dart';

void main() {
  //* Now, whenever we will compare CounterState, Dart will compare them
  //* attributes by attributes inorder to see whether they're equal or not
  final CounterState counterStateA = CounterState(counterValue: 1);
  final CounterState counterStateB = CounterState(counterValue: 1);
  //! This should return 'true' now.
  print(counterStateA == counterStateB);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  //! Named Routing
  //! 1st
  //! We want to provide a unique instance of our CounterCubit across all other
  //! screens. So this time will create the instance manually  here at the top.
  //! We will prepare the name of the variable with an underscore '_' to make
  //! the field only available inside the class.

  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final CounterCubit _counterCubit = CounterCubit();

  @override
  Widget build(BuildContext context) {
    // As you can see the top of the widgets tree is MaterialApp widget.
    // There is where the tree starts from in most of the flutter apps.
    // So inorder to make our CounterCubit available throughout the entire tree
    // over app, we must create our BlocProvider with it at our MaterialApp level.
    // All we need to do is to take the current context and return a
    // CounterCubit instatnce.
    //* So what we did now is we told Flutter to create a single & unique
    //* instance of the CounterCubit and make it available to the subtree
    //* below MaterialApp widget.
    //! To Learn the BLoC Access Concept we will move the BlocProvider to be the
    //! parent widget of HomeScreen (Widget) instead of MaterialApp (Widget).
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      //! Named Routing
      // We will list all of our routes inside the parameter of our MaterialApp.
      //* Any Application MUST HAVE a Default Home Route which will be pushed in
      //* the first place when the application starts.
      //* The Route Name for the Default Home Route MUST BE '/' since '/' is the
      //* universal sign for home in programming.
      //? How we can provide a unique instatnce of a Bloc/Cubit across all Screens?
      //! 2nd
      //! Now we have a unique instance of CounterCubit (_counterCubit) that
      //! can be provided with BlocProvider across every Screen.
      //! But:
      //! Since the only advantage of using BlocProvider is that it
      //! automatically closes the CounterCubit, but only when the CounterCubit
      //! is created inside the BlocProvider it self (not as a globale varibale),
      //? So What should we use instead?
      //! When we want to provide an existing instance of a Bloc/Cubit, we will
      //! use BlocProvider.value(value: existingInstance) Widget when we want to
      //! create and provide a Bloc/Cubit in the same place.
      //* We can't create and provide the CounterCubit for every Screen
      //* Because that would lead us to having 3 different CounterCubit instances.
      //! We should only have one unique working instance of a Bloc/Cubit.
      //! So that why we created only one here at the top, and that was it.
      //* Hence, we need to wrap all of the screens with a BlocProvider.value()
      //* widget, and provide them with our existing signal instance of
      //* CounterCubit.
      //! Remember:
      //! Remember that BlocProvider.value() won't close the provided Bloc/Cubit
      //! automatically, we will need to close it manually where we created it.
      //! More Specifically the 'MyApp' class get disposed
      routes: {
        '/': (context) => BlocProvider(
              create: (context) => _counterCubit,
              child: const HomeScreen(
                title: 'Home Screen',
                color: Colors.blueAccent,
              ),
            ),
        '/second': (context) => BlocProvider(
              create: (context) => _counterCubit,
              child: const SecondScreen(
                title: 'Second Screen',
                color: Colors.redAccent,
              ),
            ),
        '/third': (context) => BlocProvider(
              create: (context) => _counterCubit,
              child: const ThirdScreen(
                title: 'Third Screen',
                color: Colors.greenAccent,
              ),
            ),
      },
    );
  }

  //! 3rd
  //* MyApp is a stateless widget which doesn't have a dispose method, so we
  //* will have to convert it to statefull Widget and then inside of this method
  //* (override dispose method) we will need to call the close function of our
  //* CounterCubit.
  @override
  void dispose() {
    _counterCubit.close();
    super.dispose();
  }
}
